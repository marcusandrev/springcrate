part of 'get_my_users_bloc.dart';

sealed class GetMyUsersEvent extends Equatable {
  const GetMyUsersEvent();

  @override
  List<Object> get props => [];
}

class GetMyUsers extends GetMyUsersEvent {}
