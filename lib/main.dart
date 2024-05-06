import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:springcrate/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:springcrate/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final apiKey = dotenv.env['API_KEY'];
  final appId = dotenv.env['APP_ID'];
  final messagingSenderId = dotenv.env['MESSAGING_SENDER_ID'];
  final projectId = dotenv.env['PROJECT_ID'];
  final storageBucket = dotenv.env['STORAGE_BUCKET'];

  if (apiKey == null ||
      appId == null ||
      messagingSenderId == null ||
      projectId == null ||
      storageBucket == null) {
    throw Exception('Missing required environment variables in .env file');
  }

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket,
    ),
  );

  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}
