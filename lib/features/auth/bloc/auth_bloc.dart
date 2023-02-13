// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ozare/features/auth/repository/repository.dart';
import 'package:ozare/models/ouser.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required LocalDBRepository localDBRepository,
  })  : _authRepository = authRepository,
        _localDBRepository = localDBRepository,
        super(const AuthLoading(message: 'Initializing ...')) {
    on<AuthCheckRequested>(_onAuthCheckRequestedToState);
    on<AuthLoginRequested>(_onAuthLoginRequestedToState);
    on<AuthOnboardingCompleted>(_onAuthOnboardingCompletedToState);
    on<AuthSignupRequested>(_onAuthSignupRequestedToState);
    on<AuthSignupPageRequested>(_onAuthSignupPageRequestedToState);
    on<AuthLoginPageRequested>(_onAuthLoginPageRequestedToState);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  final AuthRepository _authRepository;
  final LocalDBRepository _localDBRepository;

  /// EVENT HANDLERS
  /// [AuthCheckRequested] event handler
  Future<void> _onAuthCheckRequestedToState(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    log("🧱 AuthCheckRequested event handler called ...");
    emit(const AuthLoading(message: 'Checking onboard status ...'));

    final bool? isOnboarded = _localDBRepository.getOnboardStatus();
    if (isOnboarded != null && isOnboarded) {
      final OUser? ouser = _localDBRepository.getOwner();
      if (ouser != null) {
        emit(AuthLogedIn(ouser: ouser));
      } else {
        emit(const AuthInitial());
      }
    } else {
      emit(const AuthOnboarding());
    }
  }

  /// [AuthOnboardingCompleted] event handler
  Future<void> _onAuthOnboardingCompletedToState(
    AuthOnboardingCompleted event,
    Emitter<AuthState> emit,
  ) async {
    log("🧱 AuthOnboardingCompleted event handler called ...");
    emit(const AuthLoading(message: 'Saving onboard status ...'));

    await _localDBRepository.saveOnboardStatus(true);
    emit(const AuthInitial());
  }

  /// [AuthLoginRequested] event handler
  Future<void> _onAuthLoginRequestedToState(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    log("🧱 AuthLoginRequested event handler called ...");
    emit(const AuthLoading(message: 'Logging in ...'));
    try {
      final OUser ouser = await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await _localDBRepository.saveOwner(ouser);

      emit(AuthLogedIn(ouser: ouser));
    } on FirebaseAuthException catch (e) {
      switch (e.toString()) {
        case "user-not-found":
          emit(const AuthFailure(message: "No user found for that email."));
          break;
        case "wrong-password":
          emit(const AuthFailure(
              message: "Wrong password provided for that user."));
          break;
        default:
          emit(AuthFailure(message: e.toString()));
      }
      emit(const AuthInitial());
    }
  }

  /// [AuthLogoutRequested] event handler
  /// This event handler is not async because it does not need to wait for any
  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    log("🧱 AuthLogoutRequested event handler called ...");
    emit(const AuthLoading(message: 'Logging out ...'));
    await _localDBRepository.clearOwner();
    await _authRepository.signOut();
    emit(const AuthInitial());
  }

  /// [AuthSignupRequested] event handler
  Future<void> _onAuthSignupRequestedToState(
    AuthSignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    log("🧱 AuthSignupRequested event handler called ...");
    emit(const AuthLoading(message: 'Creating your account ...'));

    try {
      final OUser ouser = await _authRepository.signUpWithEmailAndPassword(
        ouser: event.ouser,
        password: event.password,
      );
      await _localDBRepository.saveOwner(ouser);
      emit(AuthLogedIn(ouser: ouser));
    } on FirebaseAuthException catch (e) {
      switch (e.toString()) {
        case "email-already-in-use":
          emit(const AuthFailure(
              message: "The account already exists for that email."));
          break;
        default:
          emit(AuthFailure(message: e.toString()));
      }
      emit(const AuthInitial());
    }
  }

  /// [AuthSignupPageRequested] event handler
  Future<void> _onAuthSignupPageRequestedToState(
    AuthSignupPageRequested event,
    Emitter<AuthState> emit,
  ) async {
    log("🧱 AuthSignupPageRequested event handler called ...");
    emit(const AuthSignup());
  }

  /// [AuthLoginPageRequested] event handler
  Future<void> _onAuthLoginPageRequestedToState(
    AuthLoginPageRequested event,
    Emitter<AuthState> emit,
  ) async {
    log("🧱 AuthLoginPageRequested event handler called ...");
    emit(const AuthInitial());
  }
}
