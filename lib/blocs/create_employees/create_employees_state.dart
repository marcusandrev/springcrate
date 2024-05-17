part of 'create_employees_bloc.dart';

sealed class CreateEmployeesState extends Equatable {
  const CreateEmployeesState();
  
  @override
  List<Object> get props => [];
}

final class CreateEmployeesInitial extends CreateEmployeesState {}

final class CreateEmployeesFailure extends CreateEmployeesState {}
final class CreateEmployeesLoading extends CreateEmployeesState {}
final class CreateEmployeesSuccess extends CreateEmployeesState {}

final class UpdateEmployeeLoading extends CreateEmployeesState {}
final class UpdateEmployeeFailure extends CreateEmployeesState {}
final class UpdateEmployeeSuccess extends CreateEmployeesState{}
