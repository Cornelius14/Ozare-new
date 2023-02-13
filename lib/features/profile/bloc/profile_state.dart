part of 'profile_bloc.dart';

enum ProfileStatus { loading, loaded, failure }

enum PPage {
  profile,
  settings,
  editAccount,
  notifications,
  wallet,
  selectLanguage,
}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.loading,
    this.page = PPage.profile,
    this.user,
    this.message = '',
    this.history = const [],
    this.notifications = const [],
  });

  final ProfileStatus status;
  final PPage page;
  final OUser? user;
  final String message;
  final List<History> history;
  final List<Notification> notifications;

  ProfileState copyWith({
    ProfileStatus? status,
    PPage? page,
    OUser? user,
    String? message,
    List<History>? history,
    List<Notification>? notifications,
  }) {
    return ProfileState(
      status: status ?? this.status,
      page: page ?? this.page,
      user: user ?? this.user,
      message: message ?? this.message,
      history: history ?? this.history,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object> get props => [status, page, message, history, notifications];
}
