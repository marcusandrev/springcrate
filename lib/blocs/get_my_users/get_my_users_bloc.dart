import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_my_users_event.dart';
part 'get_my_users_state.dart';

class GetMyUsersBloc extends Bloc<GetMyUsersEvent, GetMyUsersState> {
  final UserRepository _userRepository;

  GetMyUsersBloc(this._userRepository) : super(GetMyUsersInitial()) {
    on<GetMyUsers>((event, emit) async {
      emit(GetMyUsersLoading());
      try {
        List<MyUser> users = await _userRepository.getUsers();
        users = users.where((user) => !user.isAdmin).toList();
        emit(GetMyUsersSuccess(users));
      } catch (e) {
        emit(GetMyUsersFailure());
      }
    });
  }
}
