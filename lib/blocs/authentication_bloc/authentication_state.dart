part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.user, this.isAdmin = false});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user, bool isAdmin)
      : this._(status: AuthenticationStatus.authenticated, user: user, isAdmin: isAdmin);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  // const AuthenticationState.admin(User user)
  //     : this._(status: AuthenticationStatus.authenticated, user: user);

  final AuthenticationStatus status;
  final User? user;
  final bool isAdmin;
  // final bool isAdmin = false;

  @override
  List<Object?> get props => [status, user, isAdmin];
}
