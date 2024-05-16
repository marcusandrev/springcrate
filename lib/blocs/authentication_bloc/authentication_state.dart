part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
    this.isAdmin = false,
    this.address,
    this.contactNumber,
    this.name,
    this.rate,
    this.userId,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated({
    required User user,
    required bool isAdmin,
    required String address,
    required String contactNumber,
    required String name,
    required String rate,
    required String userId,
  }) : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          isAdmin: isAdmin,
          address: address,
          contactNumber: contactNumber,
          name: name,
          rate: rate,
          userId: userId,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User? user;
  final bool isAdmin;
  final String? address;
  final String? contactNumber;
  final String? name;
  final String? rate;
  final String? userId;

  @override
  List<Object?> get props => [
        status,
        user,
        isAdmin,
        address,
        contactNumber,
        name,
        rate,
        userId,
      ];
}

