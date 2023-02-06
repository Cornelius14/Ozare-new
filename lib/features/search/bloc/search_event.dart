part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchRequested extends SearchEvent {
  const SearchRequested(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}

class SearchStatusChanged extends SearchEvent {
  const SearchStatusChanged(this.status);

  final SearchStatus status;

  @override
  List<Object?> get props => [status];
}
