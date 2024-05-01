import 'package:flutter/material.dart';
import 'package:springcrate/screens/employees/class_def/employee.dart';
import 'package:springcrate/screens/transactions/class_def/transaction.dart';

List<Map<String, dynamic>> netSalesData = [
  {
    'icon': 'lib/assets/sedan.svg',
    'vehicle_type': 'Sedan',
    'sales': 100000,
    'month': 'Jan',
    'year': '2024'
  },
  {
    'icon': 'lib/assets/suv.svg',
    'vehicle_type': 'SUV',
    'sales': 100000,
    'month': 'Jan',
    'year': '2024'
  },
  {
    'icon': 'lib/assets/pickup.svg',
    'vehicle_type': 'Pick-up',
    'sales': 3400,
    'month': 'Jan',
    'year': '2024'
  },
  {
    'icon': 'lib/assets/motorbike.svg',
    'vehicle_type': 'Motorbike',
    'sales': 2000,
    'month': 'Jan',
    'year': '2024'
  },
];

List<Transaction> transactionsData = [
  // {
  //   'plate_no': 'ABC 1234',
  //   'service': 'wash',
  //   'date': '03/08/2024',
  //   'time': '8:00 AM',
  //   'status': 'Not Started'
  // },
  // {
  //   'plate_no': 'BAS 1234',
  //   'service': 'wash',
  //   'date': '03/08/2024',
  //   'time': '8:00 AM',
  //   'status': 'Not Started'
  // },
  // {
  //   'plate_no': 'COB 1224',
  //   'service': 'wash',
  //   'date': '03/08/2024',
  //   'time': '8:00 AM',
  //   'status': 'Not Started'
  // },
  const Transaction('d20a1c3c-ba9c-46d7-b44f-e0cb8486f9f3', 'ABC 1234', 'sedan',
      'medium', 'wash', '7:00', '10:00', 100.00, 'Not Started', 'employee123'),
  const Transaction('3fc48480-8b2f-4af2-822b-4c7503dd4031', 'DEF 5678', 'sedan',
      'medium', 'wash', '7:00', '10:00', 100.00, 'Not Started', 'employee123'),
  const Transaction('3964d5b5-1d88-48a1-80a8-404fb987cc67', 'GHI 9012', 'sedan',
      'medium', 'wash', '7:00', '10:00', 100.00, 'Not Started', null)
];

List<Employee> employeesData = [
  // {
  //   'id': '2cb337b1-146b-4cf6-8802-db18006ad6c0',
  //   'name': 'Juan Dela Cruz',
  //   'contact_no': '09230293123',
  // },
  // {
  //   'id': 'ce5c9b96-105d-46c4-a656-baaddee2d168',
  //   'name': 'Juana Dela Cruz',
  //   'contact_no': '09230293123',
  // },
  // {
  //   'id': 'ba5ef578-fc72-4d8f-b9e6-09d48bc86948',
  //   'name': 'Joe Dela Cruz',
  //   'contact_no': '09430293123',
  // },
  // {
  //   'id': '5eaa23b8-374c-4963-a1a3-e60f44a74f0d',
  //   'name': 'Jamie Dela Cruz',
  //   'contact_no': '09230293123',
  // },
  // {
  //   'id': '0c7b4cbf-f1dd-4814-b8ff-8b1715134689',
  //   'name': 'Jamie Dela Cruz',
  //   'contact_no': '09230293123',
  // },
  // {
  //   'id': '4cd59489-6595-4296-9aea-5414726e51ae',
  //   'name': 'Jamie Dela Cruz',
  //   'contact_no': '09230293123',
  // },
  const Employee('0b5aae66-178c-499c-83db-16e097fa7fe6', 'Juan Dela Cruz',
      '60/40', '09230293123', 'Secret road', 0),
  const Employee('0474c82c-1f7a-46a6-96f9-ce8e8d80f120', 'Juana Dela Cruz',
      '60/40', '09230293123', 'Secret road', 1),
  const Employee('ad005553-a2b8-46f1-9e2e-def8ab0a880e', 'Joe Dela Cruz',
      '70/30', '09230293123', 'Secret road', 0)
];

List<Map<String, dynamic>> servicesData = [
  {
    'service_type': 'Wash',
    'vehicle_type': 'sedan',
    'vehicle_size': 'small',
  },
  {
    'service_type': 'Wash',
    'vehicle_type': 'suv',
    'vehicle_size': 'medium',
  },
  {
    'service_type': '3 Steps',
    'vehicle_type': 'van',
    'vehicle_size': 'large',
  },
];
