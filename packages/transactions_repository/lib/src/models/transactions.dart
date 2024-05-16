import '../entities/entities.dart';
import 'package:uuid/uuid.dart';

class Transactions {
  String transactionId;
  String plateNumber;
  String startDate;
  String endDate;
  String status;
  // String serviceId;
  String serviceName;
  String vehicleType;
  String vehicleSize;
  int cost;
  String userId;
  String name;

  Transactions({
    required this.transactionId,
    required this.plateNumber,
    required this.startDate,
    required this.endDate,
    required this.status,
    // required this.serviceId,
    required this.serviceName,
    required this.vehicleType,
    required this.vehicleSize,
    required this.cost,
    required this.userId,
    required this.name,
  });

  static var empty = Transactions(
    transactionId: Uuid().v4(),
    plateNumber: '',
    startDate: '0000-00-00000:00:00.000000',
    endDate: '0000-00-00000:00:00.000000',
    status: 'Not Started',
    // serviceId: 'D',
    serviceName: '',
    vehicleType: '-',
    vehicleSize: '-',
    cost: 0,
    userId: '-',
    name: '-',
  );

  Transactions copyWith({
    String? transactionId,
    String? plateNumber,
    String? startDate,
    String? endDate,
    String? status,
    // String? serviceId,
    String? serviceName,
    String? vehicleType,
    String? vehicleSize,
    int? cost,
    String? userId,
    String? name,
  }) {
    return Transactions(
      transactionId: transactionId ?? this.transactionId,
      plateNumber: plateNumber ?? this.plateNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      // serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleSize: vehicleSize ?? this.vehicleSize,
      cost: cost ?? this.cost,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }

  TransactionsEntity toEntity() {
    return TransactionsEntity(
      transactionId: transactionId,
      plateNumber: plateNumber,
      startDate: startDate,
      endDate: endDate,
      status: status,
      // serviceId: serviceId,
      serviceName: serviceName,
      vehicleType: vehicleType,
      vehicleSize: vehicleSize,
      cost: cost,
      userId: userId,
      name: name,
    );
  }

  static Transactions fromEntity(TransactionsEntity entity) {
    return Transactions(
      transactionId: entity.transactionId,
      plateNumber: entity.plateNumber,
      startDate: entity.startDate,
      endDate: entity.endDate,
      status: entity.status,
      // serviceId: entity.serviceId,
      serviceName: entity.serviceName,
      vehicleType: entity.vehicleType,
      vehicleSize: entity.vehicleSize,
      cost: entity.cost,
      userId: entity.userId,
      name: entity.name,
    );
  }

  @override
  String toString() {
    return '''
    transactionId: $transactionId, 
    plateNumber: $plateNumber, 
    startDate: $startDate, 
    endDate: $endDate, 
    status: $status, 
    serviceName: $serviceName, 
    vehicleType: $vehicleType, 
    vehicleSize: $vehicleSize, 
    cost: $cost, 
    userId: $userId, 
    name: $name 
    ''';
  }
}
