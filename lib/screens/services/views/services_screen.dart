import 'package:flutter/material.dart';
import 'package:springcrate/screens/services/class_def/service.dart';
import 'package:springcrate/screens/services/views/service_details_screen.dart';
import 'package:springcrate/widgets/searchbar.dart';
import 'package:springcrate/data/data.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

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
            child: Column(
              children: [
                for (var data in servicesData)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, _createRoute(context, data));
                    },
                    child: _buildTransactionsCard(context, data),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard(BuildContext context, Service service) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Card(
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
                  color: primaryColor),
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
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    TextButton(
                      onPressed: null, // Add functionality here
                      child: Text(
                        'More info',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute(BuildContext context, Service service) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ServiceDetailsScreen(service: service),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
