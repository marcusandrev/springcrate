import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_repository/employees_repository.dart';

class FirebaseEmployeesRepo implements EmployeesRepo {
  final employeesCollection =
      FirebaseFirestore.instance.collection('employees');

  @override
  Future<List<Employees>> getEmployees() async {
    try {
      return await employeesCollection.get().then((value) => value.docs
          .map((e) =>
              Employees.fromEntity(EmployeesEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // @override
  // Future<void> createEmployees(Employees employees) async {
  //   try {
  //     return await employeesCollection
  //         .doc(employees.userId)
  //         .set(employees.toEntity().toDocument());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }
}
