import 'package:flutter/material.dart';
import 'package:springcrate/screens/home/views/main_screen.dart';
import 'package:springcrate/screens/services/views/services_screen.dart';
import 'package:springcrate/screens/employees/views/employees_screen.dart';
import 'package:springcrate/screens/transactions/views/transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    TransactionsScreen(),
    ServicesScreen(),
    EmployeesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        title: SizedBox(
          height: AppBar().preferredSize.height,
          child: Center(
            child: Image.asset(
              'lib/assets/logo.png',
              width: 150,
            ),
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
