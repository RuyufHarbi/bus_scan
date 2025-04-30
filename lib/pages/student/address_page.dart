import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final cityController = TextEditingController();

  List<Map<String, dynamic>> districts = [];
  int? selectedDistrictId;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchDistricts();
  }

  Future<void> fetchDistricts() async {
    final response = await Supabase.instance.client
        .from('districts')
        .select()
        .order('name', ascending: true);

    setState(() {
      districts = List<Map<String, dynamic>>.from(response);
      loading = false;
    });
  }

  Future<void> saveAddress() async {
    if (streetController.text.trim().isEmpty ||
        buildingController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        selectedDistrictId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields including district.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = Supabase.instance.client.auth.currentUser!.id;

    await Supabase.instance.client.from('student_address').upsert({
      'id': userId,
      'street': streetController.text.trim(),
      'building_no': buildingController.text.trim(),
      'city': cityController.text.trim(),
      'district_id': selectedDistrictId,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Address')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: streetController,
              decoration: InputDecoration(labelText: 'Street'),
            ),
            TextField(
              controller: buildingController,
              decoration: InputDecoration(labelText: 'Building Number'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(height: 16),
            DropdownButton<int>(
              value: selectedDistrictId,
              hint: Text("Select a district"),
              isExpanded: true,
              items: districts.map((district) {
                return DropdownMenuItem<int>(
                  value: district['id'],
                  child: Text(district['name']),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  selectedDistrictId = newValue;
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: saveAddress,
              child: Text('Save Address'),
            ),
          ],
        ),
      ),
    );
  }
}
