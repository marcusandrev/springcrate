part of 'delete_services_bloc.dart';

sealed class DeleteServicesState extends Equatable {
  const DeleteServicesState();
  
  @override
  List<Object> get props => [];
}

final class DeleteServicesInitial extends DeleteServicesState {}

final class DeleteServicesLoading extends DeleteServicesState {}

final class DeleteServicesSuccess extends DeleteServicesState {}

final class DeleteServicesFailure extends DeleteServicesState {}
