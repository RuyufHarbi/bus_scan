import 'package:flutter/material.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';

class DriverHomePage extends StatelessWidget {
  final List<Map<String, String>> students = [
    {
      'name': 'Sara Ahmed',
      'address': '456 Palm Street, Taif'
    },
    {
      'name': 'Ali Hassan',
      'address': '123 King Road, Taif'
    },
    {
      'name': 'Lina Saleh',
      'address': '789 Jasmine Ave, Taif'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text('Driver Home'),
        centerTitle: true,
      ),*/
      body: Row(
          children: [
          DriverSideBar(context: context),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
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
                  title: Text(student['name'] ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(student['address'] ?? '', style: TextStyle(fontSize: 16)),
                ),
              );
            },
          ),
        )
        ],
      ),
    ),
    )
    ],
    ),
    );
  }
}
