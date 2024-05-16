import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/authentication_bloc/authentication_bloc.dart';

class RegularEditScreen extends StatelessWidget {
  const RegularEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository,
      ),
      child: _RegularEditScreen(),
    );
  }
}

class _RegularEditScreen extends StatelessWidget {
  const _RegularEditScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          final employeeDetailItems = [
            [
              _buildDetailWidget(context, 'Name', state.name),
              _buildDetailWidget(context, 'Rate', state.rate),
              _buildDetailWidget(context, 'Address', state.address),
              _buildDetailWidget(
                  context, 'Contact Number', state.contactNumber),
            ]
          ];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailWidget(context, 'Employee ID', state.userId),
                const SizedBox(height: 20),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                  ),
                  itemCount: employeeDetailItems[0].length,
                  itemBuilder: (context, index) =>
                      employeeDetailItems[0][index],
                ),
                ElevatedButton(
                  onPressed: () => _showEditProfileDialog(context),
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          );
        } else {
          return const Text('Loading...');
        }
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
        text: context.read<AuthenticationBloc>().state.name);
    final TextEditingController addressController = TextEditingController(
        text: context.read<AuthenticationBloc>().state.address);
    final TextEditingController contactNumberController = TextEditingController(
        text: context.read<AuthenticationBloc>().state.contactNumber);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String newName = nameController.text;
                final String newAddress = addressController.text;
                final String newContactNumber = contactNumberController.text;
                context.read<AuthenticationBloc>().add(
                      UpdateProfile(newName, newAddress, newContactNumber),
                    );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildDetailWidget(BuildContext context, String label, String? value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        value ?? 'N/A',
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
        ),
      ),
    ],
  );
}
