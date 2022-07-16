import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Convertex",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.purple.shade800,
          onPrimary: Colors.white,
          secondary: Colors.green,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.teal.shade50,
          onBackground: Colors.black,
          surface: Colors.purple.shade800,
          onSurface: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
