import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required this.userRepository})
      : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
    on<AuthenticationUserChanged>((event, emit) async {
      if (event.user != null) {
        final userDetails = await userRepository.getUserDetails(event.user!);
        final isAdmin = await userRepository.isAdmin(event.user!);
        emit(AuthenticationState.authenticated(
          user: event.user!,
          isAdmin: isAdmin,
          address: userDetails.address,
          contactNumber: userDetails.contactNumber,
          name: userDetails.name,
          rate: userDetails.rate,
          userId: userDetails.userId,
        ));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });

    on<UpdateProfile>((event, emit) async {
      if (state.status == AuthenticationStatus.authenticated) {
        final updatedUserDetails = await userRepository.updateUserDetails(
          state.user!,
          event.newName,
          event.newAddress,
          event.newContactNumber,
        );
        emit(AuthenticationState.authenticated(
          user: state.user!,
          isAdmin: state.isAdmin,
          address: updatedUserDetails.address,
          contactNumber: updatedUserDetails.contactNumber,
          name: updatedUserDetails.name,
          rate: updatedUserDetails.rate,
          userId: updatedUserDetails.userId,
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}