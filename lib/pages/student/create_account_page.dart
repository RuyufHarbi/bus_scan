import 'package:flutter/material.dart';
import 'package:bus_scan/supabase.dart'; // Import your supabase instance
import 'home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController(); // ADD email
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> createAccount() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = response.user;

      if (user != null) {
        final fullName = nameController.text.trim();
        final names = fullName.split(' ');
        final firstName = names.isNotEmpty ? names[0] : '';
        final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

        await supabase.from('profiles').insert({
          'id': user.id,
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneController.text.trim(),
          'role': 'student', // replace with dropdown later
          'email': user.email,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully! Please log in.')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up failed: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo2.png", height: 100),
                SizedBox(height: 30),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Full Name'),
                  ),
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email Address'), // ADD email
                  ),
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: createAccount,
                  child: Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
