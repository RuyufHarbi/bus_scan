import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/student/widgets/sidebar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int daysPresent = 0;
  double pricePerDay = 0;
  double totalDue = 0;
  bool loading = true;
  bool isPaid = false;

  @override
  void initState() {
    super.initState();
    fetchAttendanceSummary();
  }

  Future<void> fetchAttendanceSummary() async {
    final user = Supabase.instance.client.auth.currentUser;
    final userId = user!.id;

    final result = await Supabase.instance.client.rpc('get_monthly_attendance_payment', params: {
      'student_id_input': userId,
    });

    final paymentStatus = await Supabase.instance.client
        .from('payments')
        .select('paid')
        .eq('student_id', userId)
        .eq('month', DateTime.now().month.toString())
        .maybeSingle();

    if (result != null && result is List && result.isNotEmpty) {
      final data = result.first;
      setState(() {
        daysPresent = data['days_present'] ?? 0;
        pricePerDay = (data['price_per_day'] as num).toDouble();
        totalDue = (data['total_due'] as num).toDouble();
        isPaid = paymentStatus != null && paymentStatus['paid'] == true;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Attendance Summary - This Month",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      title: Text("Days Attended: $daysPresent"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Daily Fare: SAR $pricePerDay"),
                          Text("Total Due: SAR $totalDue"),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Payment Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                isPaid ? "Paid" : "Unpaid",
                                style: TextStyle(
                                  color: isPaid ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
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
