import 'package:flutter/material.dart';
import 'package:bus_scan/pages/driver/widgets/driver_sidebar.dart';

class DriverAddressPage extends StatefulWidget {
  const DriverAddressPage({Key? key}) : super(key: key);

  @override
  State<DriverAddressPage> createState() => _DriverAddressPageState();
}

class _DriverAddressPageState extends State<DriverAddressPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _districtController;
  late TextEditingController _fareController;

  @override
  void initState() {
    super.initState();
    _districtController = TextEditingController(text: 'Taif');
    _fareController = TextEditingController(text: '50');
  }

  @override
  void dispose() {
    _districtController.dispose();
    _fareController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final updatedDistrict = _districtController.text;
      final updatedFare = _fareController.text;

      // Save logic here (e.g., send to backend or local storage)

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DriverSideBar(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Text('Edit District and Fare', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _districtController,
                      decoration: InputDecoration(
                        labelText: 'District',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter district' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _fareController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Day Fare (SAR)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter fare' : null,
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveAddress,
                        child: Text('Save Changes'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[300],
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
