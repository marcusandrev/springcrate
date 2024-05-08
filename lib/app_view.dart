import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:springcrate/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:springcrate/screens/auth/welcome_screen.dart';
import 'package:springcrate/screens/regular_user/regular_user.dart';

import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "springcrate",
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            background: Colors.grey.shade100,
            onBackground: Colors.black,
            primary: Color(0xFFFF6F00),
            secondary: Color(0xFF0090FF),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(fontFamily: 'Inter'),
            bodyText2: TextStyle(fontFamily: 'Inter'),
          ),
        ),
        // home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        //     builder: (context, state) {
        //   if (state.status == AuthenticationStatus.authenticated) {
        //     return BlocProvider(
        //       create: (context) => SignInBloc(
        //           userRepository:
        //               context.read<AuthenticationBloc>().userRepository),
        //       child: const HomeScreen(),
        //     );
        //   } else {
        //     return const WelcomeScreen();
        //   }
        // })
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            if (state.isAdmin) {
              // Show admin home screen
              return BlocProvider(
                create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository,
                ),
                child: const HomeScreen(),
              );
            } else {
              // Show regular user home screen
              return BlocProvider(
                  create: (context) => SignInBloc(
                        userRepository:
                            context.read<AuthenticationBloc>().userRepository,
                      ),
                  child: const RegularUserScreen());
            }
          } else {
            // Show welcome screen
            return const WelcomeScreen();
          }
        }));
  }
}
