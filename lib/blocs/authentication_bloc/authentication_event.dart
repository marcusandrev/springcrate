part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
	final User? user;

	const AuthenticationUserChanged(this.user);
}

class CheckAdmin extends AuthenticationEvent {
  final User user;

  const CheckAdmin(this.user);
}

class UpdateProfile extends AuthenticationEvent {
  final String newName;
  final String newAddress;
  final String newContactNumber;

  const UpdateProfile(this.newName, this.newAddress, this.newContactNumber);

  @override
  List<Object> get props => [newName, newAddress, newContactNumber];
}


