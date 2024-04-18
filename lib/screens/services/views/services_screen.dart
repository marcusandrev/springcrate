import 'package:flutter/material.dart';
import 'package:springcrate/widgets/searchbar.dart';
import 'package:springcrate/data/data.dart';
import 'package:springcrate/util/string_utils.dart';

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
            child: Column(
              children: [
                for (var data in servicesData)
                  _buildTransactionsCard(
                      context,
                      data['service_type'],
                      StringUtils.capitalize(data['vehicle_type']),
                      StringUtils.capitalize(data['vehicle_size'])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard(BuildContext context, String service_type,
      String vehicle_type, String vehicle_size) {
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
              "$service_type",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            SizedBox(height: 4.0),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Type',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$vehicle_type",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle Size',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$vehicle_size",
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 120),
              ],
            ),

            Row(
              children: [
                Spacer(),
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
}
