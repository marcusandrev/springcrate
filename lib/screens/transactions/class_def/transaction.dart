class Transaction {
  final String? transactionID;
  final String plateNo;
  final String vehicleType;
  final String vehicleSize;
  final String service;
  final String startDate;
  final String endDate;
  final double cost;
  final String status;
  final String employeeID;

  const Transaction(
      this.transactionID,
      this.plateNo,
      this.vehicleType,
      this.vehicleSize,
      this.service,
      this.startDate,
      this.endDate,
      this.cost,
      this.status,
      this.employeeID);
}
