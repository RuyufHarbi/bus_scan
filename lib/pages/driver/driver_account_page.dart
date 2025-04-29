
import 'package:flutter/material.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';

class DriverAccountPage extends StatelessWidget {
  const DriverAccountPage({Key? key}) : super(key: key);

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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 90),
                          Center(
                            child: Text('Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Center(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text('Mohammed Al-Qahtani', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text('Driver ID:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Center(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text('DRV-1022', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text('Password:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Center(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text('********', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text('Phone Number:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Center(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text('0551122334', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(height: 100),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Edit', style: TextStyle(fontSize: 16, color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[200],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Sign Out', style: TextStyle(fontSize: 16, color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[200],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
