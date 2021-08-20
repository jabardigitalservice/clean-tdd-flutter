import 'package:clean_tdd_flutter/features/login/presentation/pages/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/pages/CheckDistributionScreen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cek Distribusi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
