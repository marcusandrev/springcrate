import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Employees extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String address;
  final String contactNumber;
  final bool isAdmin;
  final String rate;

  const Employees(
      {required this.userId,
      required this.email,
      required this.name,
      required this.address,
      required this.contactNumber,
      required this.isAdmin,
      required this.rate});

  static const empty = Employees(
      userId: '',
      email: '',
      name: '',
      address: '',
      contactNumber: '',
      isAdmin: false,
      rate: '');

  Employees copyWith(
      {String? userId,
      String? email,
      String? name,
      String? address,
      String? contactNumber,
      bool? isAdmin,
      String? rate}) {
    return Employees(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name,
        address: address ?? this.address,
        contactNumber: contactNumber ?? this.contactNumber,
        isAdmin: isAdmin ?? this.isAdmin,
        rate: rate ?? this.rate);
  }

  EmployeesEntity toEntity() {
    return EmployeesEntity(
        userId: userId,
        email: email,
        name: name,
        address: address,
        contactNumber: contactNumber,
        isAdmin: isAdmin,
        rate: rate);
  }

  static Employees fromEntity(EmployeesEntity entity) {
    return Employees(
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
