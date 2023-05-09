import 'package:committer_cra/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CraApp());

class CraApp extends StatelessWidget {
  const CraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Committer App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "lambda"),
      home: const LoginScreen(),
    );
  }
}
