import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/dash/repository/dash_repository.dart';
import 'package:ozare/models/league.dart';

part 'dash_event.dart';
part 'dash_state.dart';

class DashBloc extends Bloc<DashEvent, DashState> {
  DashBloc({
    required DashRepository dashRepository,
  })  : _dashRepository = dashRepository,
        super(const DashLoading()) {
    on<DashLeaguesRequested>(_onDashLeaguesRequested);
    on<DashLeaguesUpdated>(_onDashLeaguesUpdated);
    on<DashLeaguesUpdateRequested>(_onDashLeaguesUpdateRequested);
    on<DashCategoryChanged>(_onDashCategoryChanged);
  }

  final DashRepository _dashRepository;

  /// category changed
  void _onDashCategoryChanged(
    DashCategoryChanged event,
    Emitter<DashState> emit,
  ) {
    emit(const DashLoading());
    add(DashLeaguesRequested(event.category));
  }

  /// This method is called when the DashLeaguesRequested event is added.
  void _onDashLeaguesRequested(
    DashLeaguesRequested event,
    Emitter<DashState> emit,
  ) async {
    log('DashLeaguesRequested event called!');
    try {
      final leagues =
          await _dashRepository.getLeagues(categoryToStr(event.category));
      if (leagues != null) {
        if (event.category == DashCategory.soccer) {
          emit(DashSoccerState(leagues: leagues));
        } else if (event.category == DashCategory.basketball) {
          emit(DashSoccerState(leagues: leagues));
        }
        add(DashLeaguesUpdated(leagues, event.category));
      }
      //emit(state.copyWith(matches: matches, status: DashStatus.success));
    } catch (error) {
      emit(DashFailure(error.toString()));
    }
  }

  /// This method is called when the DashLeaguesUpdated event is added.
  void _onDashLeaguesUpdated(
    DashLeaguesUpdated event,
    Emitter<DashState> emit,
  ) async {
    // if (event.leagues.isEmpty) {
    //   // add delay 10 minutes
    //   await Future.delayed(const Duration(minutes: 10));
    // } else if (event.leagues.isNotEmpty) {
    //   // add delay 30 seconds
    //   await Future.delayed(const Duration(seconds: 30));
    // }
    add(DashLeaguesUpdateRequested(event.leagues, event.category));
  }

  /// ]
  /// This method is called when the DashLeaguesUpdateRequested event is added.
  void _onDashLeaguesUpdateRequested(
    DashLeaguesUpdateRequested event,
    Emitter<DashState> emit,
  ) async {
    try {
      final leagues =
          await _dashRepository.getLeagues(categoryToStr(event.category));
      if (leagues != null) {
        add(DashLeaguesUpdated(leagues, event.category));
      } else {}
    } catch (error) {
      emit(DashFailure(error.toString()));
    }
  }

  /// helper function
  String categoryToStr(DashCategory category) {
    switch (category) {
      case DashCategory.soccer:
        return 'soccer';
      case DashCategory.basketball:
        return 'basketball';
    }
  }
}
