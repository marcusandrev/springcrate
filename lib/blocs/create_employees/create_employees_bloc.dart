import 'package:bloc/bloc.dart';
import 'package:employees_repository/employees_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_employees_event.dart';
part 'create_employees_state.dart';

class CreateEmployeesBloc extends Bloc<CreateEmployeesEvent, CreateEmployeesState> {
  final EmployeesRepo employeesRepo;

  CreateEmployeesBloc({required this.employeesRepo})
      : super(CreateEmployeesInitial()) {
    on<CreateEmployees>(_onCreateEmployees);
    on<UpdateEmployee>(_onUpdateEmployee);
  }

  Future<void> _onCreateEmployees(CreateEmployees event, Emitter<CreateEmployeesState> emit) async {
    emit(CreateEmployeesLoading());
    try {
      await employeesRepo.createEmployees(event.employees);
      emit(CreateEmployeesSuccess());
    } catch (e) {
      emit(CreateEmployeesFailure());
    }
  }

  Future<void> _onUpdateEmployee(UpdateEmployee event, Emitter<CreateEmployeesState> emit) async {
    emit(UpdateEmployeeLoading());
    try {
      await employeesRepo.updateEmployee(event.employees);
      emit(UpdateEmployeeSuccess());
    } catch (e) {
      emit(UpdateEmployeeFailure());
    }
  }
}
