import '../entities/entities.dart';
import 'package:uuid/uuid.dart';

class Services {
  String serviceId;
  String serviceName;
  String promo;
  String vehicleType;
  String vehicleSize;
  int cost;

  Services({
    required this.serviceId,
    required this.serviceName,
    required this.promo,
    required this.vehicleType,
    required this.vehicleSize,
    required this.cost,
  });

  static var empty = Services(
    serviceId: const Uuid().v1(),
    serviceName: '',
    promo: '',
    vehicleType: '',
    vehicleSize: '',
    cost: 0,
  );

  Services copyWith({
    String? serviceId,
    String? serviceName,
    String? promo,
    String? vehicleType,
    String? vehicleSize,
    int? cost,
  }) {
    return Services(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      promo: promo ?? this.promo,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleSize: vehicleSize ?? this.vehicleSize,
      cost: cost ?? this.cost,
    );
  }

  ServicesEntity toEntity() {
    return ServicesEntity(
      serviceId: serviceId,
      serviceName: serviceName,
      promo: promo,
      vehicleType: vehicleType,
      vehicleSize: vehicleSize,
      cost: cost,
    );
  }

  static Services fromEntity(ServicesEntity entity) {
    return Services(
      serviceId: entity.serviceId,
      serviceName: entity.serviceName,
      promo: entity.promo,
      vehicleType: entity.vehicleType,
      vehicleSize: entity.vehicleSize,
      cost: entity.cost,
    );
  }

  @override
  String toString() {
    return '''
    serviceId: $serviceId,
    serviceName: $serviceName,
    promo: $promo,
    vehicleType: $vehicleType,
    vehicleSize: $vehicleSize,
    cost: $cost,
    ''';
  }
}
