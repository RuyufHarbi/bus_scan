import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';

class SchedulePage extends StatelessWidget {
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
                  Text('Schedule', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  // Placeholder: Replace with chart widget later
                  Container(
                    height: 300,
                    color: Colors.grey[200],
                    child: Center(child: Text('Schedule Graph')),
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
