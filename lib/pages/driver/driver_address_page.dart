import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';

class DriverAddressPage extends StatefulWidget {
  const DriverAddressPage({super.key});

  @override
  State<DriverAddressPage> createState() => _DriverAddressPageState();
}

class _DriverAddressPageState extends State<DriverAddressPage> {
  final priceController = TextEditingController();
  List<Map<String, dynamic>> districts = [];
  int? selectedDistrictId;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchDistricts();
    loadDriverInfo();
  }

  Future<void> fetchDistricts() async {
    final response = await Supabase.instance.client
        .from('districts')
        .select()
        .order('name', ascending: true);

    setState(() {
      districts = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> loadDriverInfo() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client
        .from('driver_info')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response != null) {
      setState(() {
        priceController.text = response['price_per_day']?.toString() ?? '';
        selectedDistrictId = response['district_id'];
      });
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> saveDriverInfo() async {
    if (priceController.text.trim().isEmpty || selectedDistrictId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a price and select a district.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = Supabase.instance.client.auth.currentUser!.id;
    final price = double.tryParse(priceController.text.trim());

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid number for price.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await Supabase.instance.client.from('driver_info').upsert({
      'id': userId,
      'district_id': selectedDistrictId,
      'price_per_day': price,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Driver info saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Row(
        children: [
          DriverSideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Text('Edit District and Fare', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 40),
                  Text("District", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  DropdownButton<int>(
                    value: selectedDistrictId,
                    hint: Text("Select your district"),
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
                  SizedBox(height: 20),
                  Text("Price per day (SAR)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter your price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: saveDriverInfo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: Text('Save Changes'),
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
