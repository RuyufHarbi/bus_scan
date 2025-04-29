import 'package:flutter/material.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';

class DriverPaymentPage extends StatelessWidget {
  final List<Map<String, String>> payments = [
    {'name': 'Sara Ahmed', 'status': 'Complete'},
    {'name': 'Ali Hassan', 'status': 'Incomplete'},
    {'name': 'Lina Saleh', 'status': 'Complete'},
    {'name': 'Fahad Nasser', 'status': 'Incomplete'},
  ];

  Color getStatusColor(String status) {
    return status == 'Complete' ? Colors.green[200]! : Colors.red[200]!;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Student Payment Status',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        final payment = payments[index];
                        return Card(
                          color: getStatusColor(payment['status']!),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(Icons.person, size: 40),
                            title: Text(payment['name'] ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            trailing: Text(
                              payment['status'] ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
