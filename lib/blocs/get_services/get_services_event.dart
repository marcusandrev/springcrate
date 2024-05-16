part of 'get_services_bloc.dart';

sealed class GetServicesEvent extends Equatable {
  const GetServicesEvent();

  @override
  List<Object> get props => [];
}

class GetServices extends GetServicesEvent {}

class SearchServices extends GetServicesEvent {
  final String query;

  const SearchServices(this.query);

  @override
  List<Object> get props => [query];
}
