import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/student/widgets/sidebar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isEditing = false;
  bool loading = true;
  Map<String, dynamic>? profile;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    setState(() {
      profile = response;
      firstNameController = TextEditingController(text: profile?['first_name'] ?? '');
      lastNameController = TextEditingController(text: profile?['last_name'] ?? '');
      phoneController = TextEditingController(text: profile?['phone_number'] ?? '');
      loading = false;
    });
  }

  Future<void> saveProfile() async {
    if (firstNameController.text.trim().isEmpty || lastNameController.text.trim().isEmpty || phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fields cannot be empty.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = Supabase.instance.client.auth.currentUser!.id;

    final updatedProfile = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'phone_number': phoneController.text,
    };

    await Supabase.instance.client
        .from('profiles')
        .update(updatedProfile)
        .eq('id', userId);

    setState(() {
      isEditing = false;
    });

    fetchProfile();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Row(
        children: [
          SideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 90),
                  profileField('First Name', isEditing
                      ? TextField(controller: firstNameController)
                      : Text(profile?['first_name'] ?? '')),

                  profileField('Last Name', isEditing
                      ? TextField(controller: lastNameController)
                      : Text(profile?['last_name'] ?? '')),

                  profileField('Email', Text(profile?['email'] ?? ''), readOnly: true),
                  profileField('Role', Text(profile?['role'] ?? ''), readOnly: true),

                  profileField('Phone Number', isEditing
                      ? TextField(controller: phoneController)
                      : Text(profile?['phone_number'] ?? '')),

                  SizedBox(height: 40),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          saveProfile();
                        } else {
                          setState(() => isEditing = true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                      ),
                      child: Text(isEditing ? 'Save' : 'Edit',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Supabase.instance.client.auth.signOut();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                      ),
                      child: Text('Sign Out',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileField(String label, Widget valueWidget, {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: readOnly ? Colors.blue[100] : Colors.blue[200],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: valueWidget,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
