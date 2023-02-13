import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:ozare/features/auth/repository/repository.dart';
import 'package:ozare/features/profile/repository/profile_repository.dart';
import 'package:ozare/main.dart';
import 'package:ozare/models/history.dart';
import 'package:ozare/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/models/notification.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileRepository profileRepository,
  })  : _profileRepository = profileRepository,
        super(const ProfileState()) {
    on<ProfilePageChanged>(_onProfilePageChanged);
    on<ProfileChanged>(_onProfileChanged);
    on<ProfileHistoryRequested>(_onProfileHistoryRequested);
    on<ProfileNotificationsRequested>(_onProfileNotificationsRequested);
    _ouserSubscription = _profileRepository
        .ouserStream(ouser.uid!)
        .listen((ouser) => add(ProfileChanged(ouser: ouser)));
  }

  final ProfileRepository _profileRepository;
  final OUser ouser = getIt<LocalDBRepository>().getOwner()!;
  late StreamSubscription<OUser> _ouserSubscription;

  @override
  Future<void> close() {
    _ouserSubscription.cancel();
    return super.close();
  }

  /// EVENT HANDLERS
  /// [ProfilePageChanged] event handler
  void _onProfilePageChanged(
    ProfilePageChanged event,
    Emitter<ProfileState> emit,
  ) {
    log('🧱 ProfilePageChanged: ${event.page}');
    emit(state.copyWith(page: event.page));
  }

  /// [ProfileChanged] event handler
  void _onProfileChanged(
    ProfileChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(user: event.ouser, status: ProfileStatus.loaded));
  }

  /// [ProfileHistoryRequested] event handler
  void _onProfileHistoryRequested(
    ProfileHistoryRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final List<History> history =
        await _profileRepository.getHistory(ouser.uid!);
    emit(state.copyWith(history: history, status: ProfileStatus.loaded));
  }

  /// [ProfileNotificationsRequested] event handler
  void _onProfileNotificationsRequested(
    ProfileNotificationsRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final List<Notification> notifications =
        await _profileRepository.getNotifications(ouser.uid!);
    emit(state.copyWith(
        notifications: notifications, status: ProfileStatus.loaded));
  }
}
