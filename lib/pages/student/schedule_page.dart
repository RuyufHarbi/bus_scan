import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/student/widgets/sidebar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late Future<List<Map<String, dynamic>>> scheduleFuture;

  final List<String> weekDays = [
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'
  ];

  List<String> usedDays = [];

  @override
  void initState() {
    super.initState();
    scheduleFuture = fetchSchedule();
  }

  Future<List<Map<String, dynamic>>> fetchSchedule() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client
        .from('schedules')
        .select()
        .eq('student_id', userId)
        .order('day', ascending: true);

    final scheduleList = List<Map<String, dynamic>>.from(response);
    usedDays = scheduleList.map((row) => row['day'] as String).toList();
    return scheduleList;
  }

  String formatToPgTime(String input) {
    final parts = input.split(':');
    if (parts.length == 1) {
      return '${parts[0].padLeft(2, '0')}:00:00';
    } else if (parts.length == 2) {
      return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}:00';
    } else {
      return input;
    }
  }

  String stripSeconds(String input) {
    final parts = input.split(':');
    return parts.length >= 2 ? '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}' : input;
  }

  Future<void> showScheduleDialog({Map<String, dynamic>? existing}) async {
    String? selectedDay = existing != null ? existing['day'] : null;
    final pickupController = TextEditingController(text: existing != null ? stripSeconds(existing['pickup_time']) : '');
    final dropoffController = TextEditingController(text: existing != null ? stripSeconds(existing['dropoff_time']) : '');

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existing != null ? 'Edit Schedule' : 'Add Schedule'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedDay,
              decoration: InputDecoration(labelText: 'Day'),
              items: weekDays.map((day) => DropdownMenuItem(
                value: day,
                child: Text(day),
              )).toList(),
              onChanged: (value) => selectedDay = value,
            ),
            TextFormField(
              controller: pickupController,
              decoration: InputDecoration(labelText: 'Pickup Time (e.g. 07:00 or 13)'),
              keyboardType: TextInputType.datetime,
            ),
            TextFormField(
              controller: dropoffController,
              decoration: InputDecoration(labelText: 'Drop-off Time (e.g. 14:00 or 10)'),
              keyboardType: TextInputType.datetime,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final pickup = pickupController.text.trim();
              final dropoff = dropoffController.text.trim();

              if (selectedDay == null || pickup.isEmpty || dropoff.isEmpty) return;

              if (existing == null && usedDays.contains(selectedDay)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('This day already has a schedule.')),
                );
                return;
              }

              final formattedPickup = formatToPgTime(pickup);
              final formattedDropoff = formatToPgTime(dropoff);
              final userId = Supabase.instance.client.auth.currentUser!.id;

              final Map<String, dynamic> data = {
                'student_id': userId,
                'day': selectedDay,
                'pickup_time': formattedPickup,
                'dropoff_time': formattedDropoff,
              };

              if (existing != null && existing['id'] != null) {
                await Supabase.instance.client.from('schedules').update(data).eq('id', existing['id']);
              } else {
                await Supabase.instance.client.from('schedules').insert(data);
              }

              Navigator.pop(context);
              setState(() {
                scheduleFuture = fetchSchedule();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Schedule saved successfully!')),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> deleteSchedule(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Schedule'),
        content: Text('Are you sure you want to delete this schedule entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await Supabase.instance.client.from('schedules').delete().eq('id', id);
      setState(() {
        scheduleFuture = fetchSchedule();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Schedule deleted')),
      );
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
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: scheduleFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  final schedule = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Schedule', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => showScheduleDialog(),
                        child: Text('Add New Day'),
                      ),
                      SizedBox(height: 20),
                      if (schedule.isEmpty)
                        Center(child: Text('No schedule found'))
                      else
                        ...schedule.map((row) => ListTile(
                          title: Text(row['day']),
                          subtitle: Text(
                            'Pickup: ${stripSeconds(row['pickup_time'])} | Drop-off: ${stripSeconds(row['dropoff_time'])}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => showScheduleDialog(existing: row),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => deleteSchedule(row['id']),
                              ),
                            ],
                          ),
                        )),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
