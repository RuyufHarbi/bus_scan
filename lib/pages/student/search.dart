import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/student/widgets/sidebar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? selectedDistrictId;
  List<dynamic> districts = [];
  List<dynamic> drivers = [];
  Map<String, dynamic>? assignedDriver;

  @override
  void initState() {
    super.initState();
    fetchDistricts();
    fetchAssignedDriver().then((value) {
      setState(() {
        assignedDriver = value;
      });
    });
  }

  Future<void> fetchDistricts() async {
    final response = await Supabase.instance.client.from('districts').select();
    setState(() {
      districts = response;
    });
  }

  Future<void> fetchDrivers(String districtId) async {
    final response = await Supabase.instance.client
        .from('driver_info')
        .select('price_per_day, id, profiles(first_name, last_name)')
        .eq('district_id', districtId);

    setState(() {
      drivers = response;
    });
  }

  Future<void> cancelDriver() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Driver"),
        content: Text("Are you sure you want to cancel your current driver?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("No")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text("Yes"))
        ],
      ),
    );

    if (confirm != true) return;

    final user = Supabase.instance.client.auth.currentUser;
    await Supabase.instance.client
        .from('driver_student')
        .delete()
        .eq('student_id', user!.id);

    setState(() {
      assignedDriver = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Driver assignment canceled.")),
    );
  }

  Future<void> selectDriver(String driverId) async {
    final user = Supabase.instance.client.auth.currentUser;

    // Check for unpaid dues
    final unpaidPayments = await Supabase.instance.client
        .from('payments')
        .select()
        .eq('student_id', user!.id)
        .eq('paid', false);

    if (unpaidPayments.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Unpaid Dues"),
          content: const Text("You still have unpaid dues with your current driver. Please settle them before switching."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Driver"),
        content: const Text("Are you sure you want to change your assigned driver?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Confirm"))
        ],
      ),
    );

    if (confirm != true) return;

    await Supabase.instance.client
        .from('driver_student')
        .delete()
        .eq('student_id', user.id);

    await Supabase.instance.client.from('driver_student').insert({
      'student_id': user.id,
      'driver_id': driverId,
      'start_date': DateTime.now().toIso8601String(),
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Driver selected!")));
    fetchAssignedDriver().then((value) {
      setState(() {
        assignedDriver = value;
      });
    });
  }

  Future<Map<String, dynamic>?> fetchAssignedDriver() async {
    final user = Supabase.instance.client.auth.currentUser;

    final result = await Supabase.instance.client
        .from('driver_student')
        .select('driver_info(price_per_day, profiles(first_name, last_name))')
        .eq('student_id', user!.id)
        .limit(1)
        .maybeSingle();

    return result;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Find a Driver", style: Theme.of(context).textTheme.titleLarge),

                  if (assignedDriver != null) ...[
                    Card(
                      color: Colors.green[50],
                      child: ListTile(
                        leading: Icon(Icons.directions_bus),
                        title: Text("Assigned Driver"),
                        subtitle: Text(
                          "${assignedDriver!['driver_info']['profiles']['first_name']} "
                              "${assignedDriver!['driver_info']['profiles']['last_name']} - "
                              "SAR ${assignedDriver!['driver_info']['price_per_day']} / day",
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: cancelDriver,
                          tooltip: "Cancel Driver",
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],

                  DropdownButton<String>(
                    hint: Text("Select District"),
                    value: selectedDistrictId,
                    items: districts.map<DropdownMenuItem<String>>((district) {
                      return DropdownMenuItem<String>(
                        value: district['id'].toString(),
                        child: Text(district['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDistrictId = value;
                      });
                      fetchDrivers(value!);
                    },
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: drivers.isEmpty
                        ? Center(child: Text("No drivers found for this district."))
                        : ListView.builder(
                      itemCount: drivers.length,
                      itemBuilder: (context, index) {
                        final driver = drivers[index];
                        final name = "${driver['profiles']['first_name']} ${driver['profiles']['last_name']}";
                        final fare = driver['price_per_day'];

                        return Card(
                          child: ListTile(
                            title: Text(name),
                            subtitle: Text("Daily Fare: \$${fare}"),
                            trailing: ElevatedButton(
                              onPressed: () => selectDriver(driver['id']),
                              child: Text("Select"),
                            ),
                          ),
                        );
                      },
                    ),
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
