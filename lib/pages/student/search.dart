import 'package:flutter/material.dart';
import 'package:bus_scan/pages/student/widgets/sidebar.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('search for driver')),
      body: Row(
        children: [
          SideBar(context: context),
          Text('uwu where is my cheap driver')
        ],
      )
    );
  }
}