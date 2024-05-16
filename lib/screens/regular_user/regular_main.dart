import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:springcrate/screens/regular_user/regular_edit.dart';
import 'package:springcrate/screens/regular_user/regular_home.dart'; // Make sure to import flutter_bloc

class RegularUserScreen extends StatefulWidget {
  const RegularUserScreen({Key? key}) : super(key: key);

  @override
  _RegularUserScreenState createState() => _RegularUserScreenState();
}

class _RegularUserScreenState extends State<RegularUserScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const RegularHomeScreen(),
    const RegularEditScreen(),
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
                // Dispatch the SignOutRequired event to the SignInBloc
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
                icon: Icon(Icons.account_circle_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
