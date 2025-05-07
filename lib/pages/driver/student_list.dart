import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<dynamic> assignedStudents = [];

  @override
  void initState() {
    super.initState();
    fetchAssignedStudents();
  }

  Future<void> fetchAssignedStudents() async {
    final user = Supabase.instance.client.auth.currentUser;

    final response = await Supabase.instance.client
        .from('driver_student')
        .select('start_date, profiles!student_id(first_name, last_name, email)')
        .eq('driver_id', user!.id);

    setState(() {
      assignedStudents = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DriverSideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Assigned Students", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  Expanded(
                    child: assignedStudents.isEmpty
                        ? Center(child: Text("No students assigned."))
                        : ListView.builder(
                      itemCount: assignedStudents.length,
                      itemBuilder: (context, index) {
                        final student = assignedStudents[index];
                        final profile = student['profiles'];
                        final name = "${profile['first_name']} ${profile['last_name']}";
                        final email = profile['email'];
                        final startDate = student['start_date'];

                        return Card(
                          child: ListTile(
                            title: Text(name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: $email"),
                                if (startDate != null) Text("Start Date: $startDate"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
