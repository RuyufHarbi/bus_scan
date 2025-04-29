import 'package:flutter/material.dart';
import 'package:bus_scan/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/driver/driver_home_page.dart';
import 'package:bus_scan/pages/student/home_page.dart'; // or student_home_page.dart if you separate

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String selectedRole = 'student'; // default

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
          'role': selectedRole,
          'email': user.email,
        });

        // Fetch role to confirm and redirect
        final profile = await supabase
            .from('profiles')
            .select('role')
            .eq('id', user.id)
            .maybeSingle();

        if (profile != null) {
          final role = profile['role'];

          if (role == 'driver') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>  DriverHomePage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>  HomePage()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile not found. Please try again.')),
          );
        }

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
                const SizedBox(height: 30),
                buildTextField(nameController, 'Full Name'),
                const SizedBox(height: 20),
                buildTextField(phoneController, 'Phone Number'),
                const SizedBox(height: 20),
                buildTextField(emailController, 'Email Address'),
                const SizedBox(height: 20),
                buildTextField(passwordController, 'Password', obscure: true),
                const SizedBox(height: 20),
                buildTextField(confirmPasswordController, 'Confirm Password', obscure: true),
                const SizedBox(height: 20),

                // Dropdown for Role
                DropdownButton<String>(
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                  items: ['student', 'driver'].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role[0].toUpperCase() + role.substring(1)),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: createAccount,
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, {bool obscure = false}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Colors.blue[200],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(labelText: label, border: InputBorder.none, contentPadding: EdgeInsets.all(10)),
      ),
    );
  }
}
