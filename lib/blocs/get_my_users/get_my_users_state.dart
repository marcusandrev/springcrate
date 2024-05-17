part of 'get_my_users_bloc.dart';

sealed class GetMyUsersState extends Equatable {
  const GetMyUsersState();

  @override
  List<Object> get props => [];
}

final class GetMyUsersInitial extends GetMyUsersState {}

final class GetMyUsersFailure extends GetMyUsersState {}

final class GetMyUsersLoading extends GetMyUsersState {}

final class GetMyUsersSuccess extends GetMyUsersState {
  final List<MyUser> myUsers;

  const GetMyUsersSuccess(this.myUsers);

  @override
  List<Object> get props => [myUsers];
}

final class GetMyUsersByUserIdSuccess extends GetMyUsersState {
  final List<MyUser> myUsers;

  const GetMyUsersByUserIdSuccess(this.myUsers);

  @override
  List<Object> get props => [myUsers];
}

final class GetMyUsersByUserIdFailure extends GetMyUsersState {}

final class GetMyUsersByUserIdLoading extends GetMyUsersState {}
