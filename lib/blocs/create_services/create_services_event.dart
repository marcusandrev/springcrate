part of 'create_services_bloc.dart';

sealed class CreateServicesEvent extends Equatable {
  const CreateServicesEvent();

  @override
  List<Object> get props => [];
}

class CreateServices extends CreateServicesEvent {
  final Services services;

  const CreateServices(this.services);

  @override
  List<Object> get props => [services];
}