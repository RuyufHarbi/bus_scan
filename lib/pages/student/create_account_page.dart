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
              SizedBox(height: 30),

              Center(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ), color: Colors.blue[200],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: TextField(controller: nameController, decoration: InputDecoration(labelText: 'Full Name'))
                ),
              ),SizedBox(height: 20),
              Center(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ), color: Colors.blue[200],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone Number'))

                ),
              ),
              SizedBox(height: 20),
              Center(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ), color: Colors.blue[200],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password'))
                ),
              ), SizedBox(height: 20),
              Center(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ), color: Colors.blue[200],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: TextField(controller: confirmPasswordController, obscureText: true, decoration: InputDecoration(labelText: 'Confirm Password'))
                ),
              ),
              SizedBox(height: 30),
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
