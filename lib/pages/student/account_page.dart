import 'package:flutter/material.dart';
import '../../widgets/sidebar.dart';
class AccountPage extends StatelessWidget {
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
                  Text('Account Info', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
    Expanded(
    child: Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    Text('Haya Im Alanazi', style: TextStyle(fontSize: 18)),
    SizedBox(height: 10),

    Text('ID:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    Text('444701541', style: TextStyle(fontSize: 18)),
    SizedBox(height: 10),

    Text('Password:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    Text('********', style: TextStyle(fontSize: 18)),
    SizedBox(height: 10),

    Text('Phone Number:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    Text('0554656812', style: TextStyle(fontSize: 18)),
    SizedBox(height: 30),

    // Action Buttons


              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Edit button color
                  ),
                ),
              ),
              SizedBox(width: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Sign Out', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Sign Out button color
                  ),
                ),
              )],
              ),
            ),
          )
    ])
            )
          )]
      ),
          );

  }
  Widget infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.label),
          SizedBox(width: 10),
          Text('$label: $value', style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }
}