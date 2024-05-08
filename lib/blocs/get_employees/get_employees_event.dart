part of 'get_employees_bloc.dart';

sealed class GetEmployeesEvent extends Equatable {
  const GetEmployeesEvent();

  @override
  List<Object> get props => [];
}

class GetEmployees extends GetEmployeesEvent{}
