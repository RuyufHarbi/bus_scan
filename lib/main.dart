import 'package:flutter/material.dart';
import 'pages/student/login_page.dart';

void main() {
  runApp(BuScanApp());
}
//haya
class BuScanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

