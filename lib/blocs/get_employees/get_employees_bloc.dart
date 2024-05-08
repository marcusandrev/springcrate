import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_employees_event.dart';
part 'get_employees_state.dart';

class GetEmployeesBloc extends Bloc<GetEmployeesEvent, GetEmployeesState> {
  GetEmployeesBloc() : super(GetEmployeesInitial()) {
    on<GetEmployeesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
