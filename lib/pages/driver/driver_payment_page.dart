import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';

class DriverPaymentPage extends StatefulWidget {
  const DriverPaymentPage({super.key});

  @override
  State<DriverPaymentPage> createState() => _DriverPaymentPageState();
}

class _DriverPaymentPageState extends State<DriverPaymentPage> {
  List<Map<String, dynamic>> studentSummaries = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAttendanceBasedPayments();
  }

  Future<void> fetchAttendanceBasedPayments() async {
    final driverId = Supabase.instance.client.auth.currentUser!.id;

    final attendanceResponse = await Supabase.instance.client.rpc(
      'get_driver_attendance_summary',
      params: {'driver_id_input': driverId},
    );

    final paymentResponse = await Supabase.instance.client
        .from('payments')
        .select('student_id, paid, month')
        .eq('driver_id', driverId)
        .eq('month', DateTime.now().month.toString());

    final Map<String, dynamic> paymentMap = {
      for (var item in paymentResponse) item['student_id']: item['paid'],
    };

    setState(() {
      studentSummaries = List<Map<String, dynamic>>.from(attendanceResponse).map((student) {
        final studentId = student['student_id'];
        final isPaid = paymentMap[studentId] == true;
        return {
          ...student,
          'paid': isPaid,
        };
      }).toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DriverSideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Student Attendance-Based Payments",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: studentSummaries.length,
                      itemBuilder: (context, index) {
                        final student = studentSummaries[index];
                        final name = student['first_name'] + ' ' + student['last_name'];
                        final email = student['email'];
                        final days = student['days_present'];
                        final fare = student['price_per_day'];
                        final total = student['total_due'];
                        final paid = student['paid'] == true;

                        return Card(
                          child: ListTile(
                            title: Text(name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: $email"),
                                Text("Days Present: $days"),
                                Text("Daily Fare: SAR $fare"),
                                Text("Total Due: SAR $total"),
                                Text(
                                  paid ? "Status: Paid" : "Status: Unpaid",
                                  style: TextStyle(
                                    color: paid ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
