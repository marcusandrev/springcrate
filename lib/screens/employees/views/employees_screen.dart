import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/get_my_users/get_my_users_bloc.dart';
import 'package:springcrate/screens/employees/views/employee_details_screen.dart';
import 'package:springcrate/widgets/searchbar.dart';
import 'package:user_repository/user_repository.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMyUsersBloc(FirebaseUserRepo())..add(GetMyUsers()),
      child: const _EmployeesScreen(),
    );
  }
}

class _EmployeesScreen extends StatelessWidget {
  const _EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Searchbar(
            searchContext: "Employees",
            borderColor: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.primary,
            context: context,
          ),
          const SizedBox(height: 20),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildEmployeesCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesCard(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return BlocBuilder<GetMyUsersBloc, GetMyUsersState>(
      builder: (context, state) {
        if (state is GetMyUsersLoading) {
          return const CircularProgressIndicator();
        } else if (state is GetMyUsersSuccess) {
          print('Number of cards created: ${state.myUsers.length}');
          
          // Get the names of users with empty rates
          List<String> usersWithEmptyRates = state.myUsers
              .where((myUsers) => myUsers.rate.isEmpty)
              .map((myUsers) => myUsers.name)
              .toList();
          
          bool hasEmptyRates = usersWithEmptyRates.isNotEmpty;

          return Column(
            children: [
              if (hasEmptyRates)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.redAccent,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.white),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            'Some employees have empty rates: ${usersWithEmptyRates.join(', ')}. Please update their information.',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ...state.myUsers.map((myUsers) {
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => EmployeeDetailsScreen(
                          myUsers: myUsers,
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
                            myUsers.name,
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
                                      'Contact No.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(myUsers.contactNumber)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(myUsers.rate.isEmpty ? '-' : myUsers.rate),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 4),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
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
