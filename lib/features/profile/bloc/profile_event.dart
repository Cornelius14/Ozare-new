part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class ProfileChanged extends ProfileEvent {
  const ProfileChanged({required this.ouser});
  final OUser ouser;
  @override
  List<Object> get props => [ouser];
}

class ProfilePageChanged extends ProfileEvent {
  const ProfilePageChanged(this.page);
  final PPage page;
  @override
  List<Object> get props => [page];
}

class ProfileHistoryRequested extends ProfileEvent {
  const ProfileHistoryRequested();
  @override
  List<Object> get props => [];
}

class ProfileNotificationsRequested extends ProfileEvent {
  const ProfileNotificationsRequested();
  @override
  List<Object> get props => [];
}
