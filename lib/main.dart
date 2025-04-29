import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/student/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ezhfnyfstvugftcyezdf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6aGZueWZzdHZ1Z2Z0Y3llemRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4Njc2MzMsImV4cCI6MjA2MTQ0MzYzM30.qUFOh0L8Qw_Ck31aP7kBFL_n_C2McucqSFB7o4Pr_Sk',
  );


  runApp(BuScanApp());
}

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

