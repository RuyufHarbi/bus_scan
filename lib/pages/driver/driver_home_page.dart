import 'package:flutter/material.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? profile;

  final List<Map<String, String>> students = [
    {'name': 'Sara Ahmed', 'address': '456 Palm Street, Taif'},
    {'name': 'Ali Hassan', 'address': '123 King Road, Taif'},
    {'name': 'Lina Saleh', 'address': '789 Jasmine Ave, Taif'},
  ];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      setState(() {
        profile = response;
      });
    }
  }

  // دالة لإرسال إشعار للطلاب عند الضغط على زر "اقتربت"
  Future<void> _sendProximityAlert() async {
    await supabase.from('notifications').insert({
      'message': '🚍 السائق اقترب من موقعك',
      'type': 'driver',
    });

    // عرض إشعار للسائق داخل التطبيق
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🚍 السائق اقترب من موقعك'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DriverSideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: profile == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Todays Attending Students',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Icon(Icons.person, size: 40, color: Colors.blue),
                            title: Text(
                              student['name'] ?? '',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              student['address'] ?? '',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _sendProximityAlert, // استدعاء الدالة عند الضغط على الزر
                      icon: Icon(Icons.directions_bus),
                      label: Text('اقتربت'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
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
}
