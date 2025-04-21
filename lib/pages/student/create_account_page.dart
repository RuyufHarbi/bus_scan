import 'package:flutter/material.dart';
import 'home_page.dart';
import '../../widgets/sidebar.dart';


class CreateAccountPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo2.png", height: 100),
              SizedBox(height: 20),
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Full Name')),
              TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone Number')),
              TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
              TextField(controller: confirmPasswordController, obscureText: true, decoration: InputDecoration(labelText: 'Confirm Password')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // go to home
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
