import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:springcrate/screens/employees/widgets/employee_form.dart';
import 'package:springcrate/screens/home/views/main_screen.dart';
import 'package:springcrate/screens/services/views/services_screen.dart';
import 'package:springcrate/screens/employees/views/employees_screen.dart';
import 'package:springcrate/screens/services/widgets/service_form.dart';
import 'package:springcrate/screens/transactions/views/transactions_screen.dart';
import 'package:springcrate/screens/transactions/widgets/transaction_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const TransactionsScreen(),
    const ServicesScreen(),
    const EmployeesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  dynamic _getBottomSheetForm(BuildContext context) {
    if (_selectedIndex == 0) {
      return null;
    }

    final List<dynamic> bottomSheetOptions = [
      null,
      TransactionForm(),
      ServiceForm(),
      EmployeeForm(context: context)
    ];

    return bottomSheetOptions[_selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    dynamic bottomSheetForm = _getBottomSheetForm(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(40),
        //   ),
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: AppBar().preferredSize.height,
              child: Center(
                child: Image.asset(
                  'lib/assets/logo.png',
                  width: 150,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Transactions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_car), label: 'Services'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group), label: 'Employees'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 3
          ? null
          : FloatingActionButton(
              onPressed: () {
                if (bottomSheetForm != null) {
                  showModalBottomSheet<dynamic>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [bottomSheetForm],
                        );
                      });
                }
              },
              shape: const CircleBorder(),
              child: Icon(Icons.add),
            ),
    );
  }
}
