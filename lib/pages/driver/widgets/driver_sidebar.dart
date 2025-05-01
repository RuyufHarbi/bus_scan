import 'package:flutter/material.dart';
import 'package:bus_scan/pages/driver/driver_address_page.dart';
import 'package:bus_scan/pages/driver/driver_account_page.dart';
import 'package:bus_scan/pages/driver/driver_schedule_page.dart';
import 'package:bus_scan/pages/driver/driver_payment_page.dart';
import 'package:bus_scan/pages/driver/driver_home_page.dart';
import 'package:bus_scan/pages/shared/menu_page.dart';
import 'package:bus_scan/pages/shared/login_page.dart';
class DriverSideBar extends StatelessWidget {
  final BuildContext context;

  const DriverSideBar({required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.blue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, size: 70),
            onSelected: (value) {
              switch (value) {
                case 'address':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DriverAddressPage()),
                  );
                  break;
                case 'about':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MenuPage()), // Replace with your About Us page
                  );
                  break;
                case 'logout':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'address',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  child: Text('Address', style: TextStyle(fontSize: 42)),
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  child: Text('About Us', style: TextStyle(fontSize: 42)),
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  child: Text('Log Out', style: TextStyle(fontSize: 42)),
                ),
              ),
            ],
          ),

          SizedBox(height: 130),
          //home iconeee
          IconButton(
            icon: Icon(Icons.home, size: 70.0),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverHomePage()),
            ),
          ),

          SizedBox(height: 20),
          // Account button
          IconButton(
            icon: Icon(Icons.account_circle_outlined, size: 70.0),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverAccountPage()),
            ),
          ),

          SizedBox(height: 20),

          // Schedule button
          /*IconButton(
            icon: Icon(Icons.calendar_month_outlined, size: 70.0),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverSchedulePage()),
            ),
          ),

          SizedBox(height: 20),*/

          // Payment button
          IconButton(
            icon: Icon(Icons.payments_outlined, size: 70.0),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverPaymentPage()),
            ),
          ),
        ],
      ),
    );
  }
}
