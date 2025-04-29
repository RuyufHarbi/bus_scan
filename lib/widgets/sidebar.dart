import 'package:bus_scan/pages/student/address_page.dart';
import 'package:bus_scan/pages/student/login_page.dart';
import 'package:flutter/material.dart';
import '../pages/student/home_page.dart';
import '../pages/student/account_page.dart';
import '../pages/student/menu_page.dart';
import '../pages/student/schedule_page.dart';
import '../pages/student/payment_page.dart';
import 'sidebar.dart';

class SideBar extends StatelessWidget {
  final BuildContext context;

  const SideBar({required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100, color: Colors.blue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //IconButton(icon: Icon(Icons.menu,size:70.0), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MenuPage()))),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, size: 70), // or any icon you like
            onSelected: (value) {
              switch (value) {
                case 'address':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddressPage(city: 'taif', address: '102 cedron chace', houseNumber: '123', moreDetails: 'gogo')), // Replace with your About Us page
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
                  child: Text(
                    'Address',
                    style: TextStyle(fontSize: 42), // Bigger text
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  child: Text(
                    'About Us',
                    style: TextStyle(fontSize: 42), // Bigger text
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 42), // Bigger text
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 130),
          IconButton(icon: Icon(Icons.qr_code_scanner,size:70.0), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()))),
          SizedBox(height: 20),
          IconButton(icon: Icon(Icons.account_circle_outlined,size:70.0), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountPage()))),
          SizedBox(height: 20),
          IconButton(icon: Icon(Icons.calendar_month_outlined,size:70.0), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SchedulePage()))),
          SizedBox(height: 20),
          IconButton(icon: Icon(Icons.payments_outlined,size:70.0), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentPage()))),

        ],
      ),//

      );
  }
}
