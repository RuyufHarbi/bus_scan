import 'package:flutter/material.dart';
import '../pages/student/home_page.dart';
import '../pages/student/account_page.dart';
import '../pages/student/menu_page.dart';
import '../pages/student/schedule_page.dart';
import '../pages/student/payment_page.dart';


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
          IconButton(icon: Icon(Icons.menu,size:70.0), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MenuPage()))),
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
