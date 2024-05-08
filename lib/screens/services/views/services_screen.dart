import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_repository/services_repository.dart';
import 'package:springcrate/blocs/get_services/get_services_bloc.dart';
import 'package:springcrate/screens/services/views/service_details_screen.dart';
import 'package:springcrate/widgets/searchbar.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetServicesBloc(FirebaseServiceRepo())..add(GetServices()),
      child: const _ServiceScreen(),
    );
  }
}

class _ServiceScreen extends StatelessWidget {
  const _ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Searchbar(
            borderColor: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _buildTransactionsCard(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return BlocBuilder<GetServicesBloc, GetServicesState>(
      builder: (context, state) {
        if (state is GetServicesLoading) {
          return const CircularProgressIndicator();
        } else if (state is GetServicesSuccess) {
          print('Number of cards created: ${state.services.length}');

          return Column(
            children: state.services.map((service) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ServiceDetailsScreen(
                        service: service,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${service.serviceName} - ${service.vehicleType.toUpperCase()}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cost',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${service.cost}',
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Size',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  service.vehicleSize,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.chevron_right,
                                  color: secondaryColor,
                                ),
                                Text(
                                  'More info',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: Text("An error has occurred..."),
          );
        }
      },
    );
  }
}


//   Route _createRoute(BuildContext context, Service service) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           ServiceDetailsScreen(service: service),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }
// }
