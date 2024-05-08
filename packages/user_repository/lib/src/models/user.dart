import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String address;
  final String contactNumber;
  final bool isAdmin;
  final String rate;

  const MyUser(
      {required this.userId,
      required this.email,
      required this.name,
      required this.address,
      required this.contactNumber,
      required this.isAdmin,
      required this.rate});

  static const empty = MyUser(
      userId: '',
      email: '',
      name: '',
      address: '',
      contactNumber: '',
      isAdmin: false,
      rate: '');

  MyUser copyWith(
      {String? userId,
      String? email,
      String? name,
      String? address,
      String? contactNumber,
      bool? isAdmin,
      String? rate}) {
    return MyUser(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name,
        address: address ?? this.address,
        contactNumber: contactNumber ?? this.contactNumber,
        isAdmin: isAdmin ?? this.isAdmin,
        rate: rate ?? this.rate);
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: userId,
        email: email,
        name: name,
        address: address,
        contactNumber: contactNumber,
        isAdmin: isAdmin,
        rate: rate);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        email: entity.email,
        name: entity.name,
        address: entity.address,
        contactNumber: entity.contactNumber,
        isAdmin: entity.isAdmin,
        rate: entity.rate);
  }

  @override
  List<Object?> get props =>
      [userId, email, name, address, contactNumber, isAdmin, rate];
}
