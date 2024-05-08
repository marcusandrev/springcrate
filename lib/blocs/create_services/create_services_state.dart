part of 'create_services_bloc.dart';

sealed class CreateServicesState extends Equatable {
  const CreateServicesState();
  
  @override
  List<Object> get props => [];
}

final class CreateServicesInitial extends CreateServicesState {}

final class CreateServicesFailure extends CreateServicesState {}
final class CreateServicesLoading extends CreateServicesState {}
final class CreateServicesSuccess extends CreateServicesState {}