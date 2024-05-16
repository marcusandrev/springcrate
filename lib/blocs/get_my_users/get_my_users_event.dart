part of 'get_my_users_bloc.dart';

sealed class GetMyUsersEvent extends Equatable {
  const GetMyUsersEvent();

  @override
  List<Object> get props => [];
}

class GetMyUsers extends GetMyUsersEvent {}

class SearchEmployees extends GetMyUsersEvent {
  final String query;

  const SearchEmployees(this.query);

  @override
  List<Object> get props => [query];
}
