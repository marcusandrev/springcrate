class ServicesEntity {
  String serviceId;
  String serviceName;
  String promo;
  String vehicleType;
  String vehicleSize;
  int cost;

  ServicesEntity({
    required this.serviceId,
    required this.serviceName,
    required this.promo,
    required this.vehicleType,
    required this.vehicleSize,
    required this.cost,
  });

  Map<String, Object?> toDocument() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'promo': promo,
      'vehicleType': vehicleType,
      'vehicleSize': vehicleSize,
      'cost': cost,
    };
  }

  static ServicesEntity fromDocument(Map<String, dynamic> doc) {
    return ServicesEntity(
      serviceId: doc['serviceId'],
      serviceName: doc['serviceName'],
      promo: doc['promo'],
      vehicleType: doc['vehicleType'],
      vehicleSize: doc['vehicleSize'],
      cost: doc['cost'],
    );
  }
}
