import 'package:flutter/material.dart';
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
  const Transaction('1234', 'ABC 1234', 'sedan', 'medium', 'wash', '7:00',
      '10:00', 100.00, 'Not Started', 'employee123'),
  const Transaction('1234', 'ABC 1234', 'sedan', 'medium', 'wash', '7:00',
      '10:00', 100.00, 'Not Started', 'employee123'),
  const Transaction('1234', 'ABC 1234', 'sedan', 'medium', 'wash', '7:00',
      '10:00', 100.00, 'Not Started', 'employee123')
];

List<Map<String, dynamic>> employeesData = [
  {
    'name': 'Juan Dela Cruz',
    'contact_no': '09230293123',
  },
  {
    'name': 'Juana Dela Cruz',
    'contact_no': '09230293123',
  },
  {
    'name': 'Joe Dela Cruz',
    'contact_no': '09430293123',
  },
  {
    'name': 'Jamie Dela Cruz',
    'contact_no': '09230293123',
  },
  {
    'name': 'Jamie Dela Cruz',
    'contact_no': '09230293123',
  },
  {
    'name': 'Jamie Dela Cruz',
    'contact_no': '09230293123',
  },
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
