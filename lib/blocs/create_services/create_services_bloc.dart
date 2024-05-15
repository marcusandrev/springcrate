import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:services_repository/services_repository.dart';

part 'create_services_event.dart';
part 'create_services_state.dart';

class CreateServicesBloc
    extends Bloc<CreateServicesEvent, CreateServicesState> {
  final ServiceRepo serviceRepo;

  CreateServicesBloc({required this.serviceRepo})
      : super(CreateServicesInitial()) {
    on<CreateServices>((event, emit) async {
      emit(CreateServicesLoading());
      try {
        await serviceRepo.createServices(event.services);
        emit(CreateServicesSuccess());
      } catch (e) {
        emit(CreateServicesFailure());
      }
    });

    on<UpdateService>((event, emit) async {
      emit(UpdateServiceLoading());
      try {
        await serviceRepo.updateService(event.services);
        emit(UpdateServiceSuccess());
      } catch (e) {
        emit(UpdateServiceFailure());
      }
    });
  }
}
