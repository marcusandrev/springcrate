part of 'get_services_bloc.dart';

sealed class GetServicesState extends Equatable {
  const GetServicesState();
  
  @override
  List<Object> get props => [];
}

final class GetServicesInitial extends GetServicesState {}

final class GetServicesFailure extends GetServicesState {}
final class GetServicesLoading extends GetServicesState {}
final class GetServicesSuccess extends GetServicesState {
  final List<Services> services;

  const GetServicesSuccess(this.services);

  @override
  List<Object> get props => [services];
}