import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/sign_in_bloc/sign_in_bloc.dart'; // Make sure to import flutter_bloc

class RegularUserScreen extends StatelessWidget {
  const RegularUserScreen({Key? key}) : super(key: key);

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
      body: Center(
        child: Text('Regular User Screen'),
      ),
    );
  }
}
