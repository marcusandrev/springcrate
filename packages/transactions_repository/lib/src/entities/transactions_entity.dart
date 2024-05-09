class TransactionsEntity {
  String transactionId;
  String plateNumber;
  String startDate;
  String endDate;
  String status;
  String serviceId;
  String serviceName;
  String vehicleType;
  String vehicleSize;
  int cost;
  String userId;
  String name;

  TransactionsEntity({
    required this.transactionId,
    required this.plateNumber,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.serviceId,
    required this.serviceName,
    required this.vehicleType,
    required this.vehicleSize,
    required this.cost,
    required this.userId,
    required this.name,
  });

  Map<String, dynamic> toDocument() {
    return {
      'transactionId': transactionId,
      'plateNumber': plateNumber,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'vehicleType': vehicleType,
      'vehicleSize': vehicleSize,
      'cost': cost,
      'userId': userId,
      'name': name,
    };
  }

  static TransactionsEntity fromDocument(Map<String, dynamic> doc) {
    return TransactionsEntity(
      transactionId: doc['transactionId'],
      plateNumber: doc['plateNumber'],
      startDate: doc['startDate'],
      endDate: doc['endDate'],
      status: doc['status'],
      serviceId: doc['serviceId'],
      serviceName: doc['serviceName'],
      vehicleType: doc['vehicleType'],
      vehicleSize: doc['vehicleSize'],
      cost: doc['cost'],
      userId: doc['userId'],
      name: doc['name'],
    );
  }
}
