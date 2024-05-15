import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:services_repository/services_repository.dart';

part 'delete_services_event.dart';
part 'delete_services_state.dart';

class DeleteServicesBloc extends Bloc<DeleteServicesEvent, DeleteServicesState> {
  final ServiceRepo serviceRepo;

  DeleteServicesBloc({required this.serviceRepo}) : super(DeleteServicesInitial());

  Stream<DeleteServicesState> _mapDeleteServiceToState(DeleteService event) async* {
    yield DeleteServicesLoading();
    try {
      await serviceRepo.deleteService(event.serviceId);
      yield DeleteServicesSuccess();
    } catch (_) {
      yield DeleteServicesFailure();
    }
  }
}
