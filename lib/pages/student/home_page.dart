import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert'; // استيراد مكتبة jsonDecode
import 'package:qr_code_scanner/qr_code_scanner.dart'; // استيراد مكتبة الماسح الضوئي

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? profile;
  QRViewController? controller; // لإدارة الماسح الضوئي
  final GlobalKey qrKey = GlobalKey(); // استخدام GlobalKey بدون تحديد النوع

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      setState(() {
        profile = response;
      });
    }
  }

  Future<void> _registerAttendance(String scannedData) async {
    try {
      final qrData = jsonDecode(scannedData);
      final userId = qrData['id'];
      final now = DateTime.now();

      final response = await supabase
          .from('attendance')
          .insert({
        'user_id': userId,
        'date': now.toIso8601String().split('T')[0],
        'time': now.toIso8601String().split('T')[1].substring(0, 8),
        'present': true,
      });

      if (response.error != null) {
        print('خطأ: ${response.error!.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ خطأ: ${response.error!.message}')),
        );
      } else {
        print('✅ تم تسجيل الحضور');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ تم تسجيل حضور الطالب')),
        );
      }
    } catch (e) {
      print('فشل في تحليل QR: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ فشل في قراءة QR')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar هنا يمكن استخدام Sidebar مخصص للطالب
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: profile == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${profile!['first_name']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Scan QR to mark your attendance',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),

                  // الماسح الضوئي للكود QR
                  Container(
                    height: 400,
                    child: QRView(
                      key: qrKey, // إضافة المفتاح بدون تحديد النوع
                      onQRViewCreated: (QRViewController controller) {
                        this.controller = controller;
                        controller.scannedDataStream.listen((scanData) {
                          // تحقق من أن القيمة ليست null قبل استخدامها
                          if (scanData.code != null) {
                            _registerAttendance(scanData.code!); // عند مسح الكود، تسجل الحضور
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
