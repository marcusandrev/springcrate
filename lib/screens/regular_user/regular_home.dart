import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/authentication_bloc/authentication_bloc.dart';

class RegularHomeScreen extends StatelessWidget {
  const RegularHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: context.read<AuthenticationBloc>().userRepository,
      ),
      child: const _RegularHomeScreen(),
    );
  }
}

class _RegularHomeScreen extends StatelessWidget {
  const _RegularHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${state.name}'),
            Text('Contact Number: ${state.contactNumber}'),
            Text('Address: ${state.address}')
          ],
        );
      } else {
        return const Text('Loading...');
      }
    });
  }
}
