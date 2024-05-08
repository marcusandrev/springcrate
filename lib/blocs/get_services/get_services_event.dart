part of 'get_services_bloc.dart';

sealed class GetServicesEvent extends Equatable {
  const GetServicesEvent();

  @override
  List<Object> get props => [];
}

class GetServices extends GetServicesEvent{}