import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/example/app/app_example.dart';
import 'src/example/web/web_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter curve',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: kIsWeb ? const CurveWebExamplePage(): const CurveExampleAppPage(),
    );
  }
}
