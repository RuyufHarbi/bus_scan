import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class PaymentPage extends StatelessWidget {
  final List<String> payments = [
    'Feb: 200 SAR',
    'Mar: 200 SAR',
    'Apr: 200 SAR',
    'May: 200 SAR',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Monthly Payments', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  ...payments.map((p) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(p, style: TextStyle(fontSize: 18)),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}