part of 'delete_services_bloc.dart';

sealed class DeleteServicesEvent extends Equatable {
  const DeleteServicesEvent();

  @override
  List<Object> get props => [];
}

class DeleteService extends DeleteServicesEvent {
  final String serviceId;

  const DeleteService({required this.serviceId});

  @override
  List<Object> get props => [serviceId];
}