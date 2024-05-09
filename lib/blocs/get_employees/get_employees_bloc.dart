import 'package:bloc/bloc.dart';
import 'package:employees_repository/employees_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_employees_event.dart';
part 'get_employees_state.dart';

class GetEmployeesBloc extends Bloc<GetEmployeesEvent, GetEmployeesState> {
  final EmployeesRepo _employeesRepo;

  GetEmployeesBloc(this._employeesRepo) : super(GetEmployeesInitial()) {
    on<GetEmployees>((event, emit) async {
      emit(GetEmployeesLoading());
      try {
        List<Employees> transactions = await _employeesRepo.getEmployees();
        emit(GetEmployeesSuccess(transactions));
      } catch (e) {
        emit(GetEmployeesFailure());
      }
    });
  }
}
