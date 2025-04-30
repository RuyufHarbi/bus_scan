
import 'package:flutter/material.dart';

import 'package:bus_scan/pages/student/widgets/sidebar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(context: context), // Left sidebar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome, Haya', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.qr_code, size: 200),
                        Text('445HYA1', style: TextStyle(fontSize: 18))
                      ],
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