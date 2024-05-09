import 'package:equatable/equatable.dart';

class EmployeesEntity extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String address;
  final String contactNumber;
  final bool isAdmin;
  final String rate;

  const EmployeesEntity(
      {required this.userId,
      required this.email,
      required this.name,
      required this.address,
      required this.contactNumber,
      required this.isAdmin,
      required this.rate});

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
      'isAdmin': isAdmin,
      'rate': rate
    };
  }

  static EmployeesEntity fromDocument(Map<String, dynamic> doc) {
    return EmployeesEntity(
        userId: doc['userId'],
        email: doc['email'],
        name: doc['name'],
        address: doc['address'],
        contactNumber: doc['contactNumber'],
        isAdmin: doc['isAdmin'],
        rate: doc['rate']);
  }

  @override
  List<Object?> get props =>
      [userId, email, name, address, contactNumber, isAdmin, rate];
}
