import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:services_repository/services_repository.dart';

part 'get_services_event.dart';
part 'get_services_state.dart';

class GetServicesBloc extends Bloc<GetServicesEvent, GetServicesState> {
  final ServiceRepo _servicesRepo;

  GetServicesBloc(this._servicesRepo) : super(GetServicesInitial()) {
    on<GetServices>((event, emit) async {
      emit(GetServicesLoading());
      try {
        List<Services> pizzas = await _servicesRepo.getServices();
        emit(GetServicesSuccess(pizzas));
      } catch (e) {
        emit(GetServicesFailure());
      }
    });
  }
}
