import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  final String city;
  final String address;
  final String houseNumber;
  final String moreDetails;

  const AddressPage({
    Key? key,
    required this.city,
    required this.address,
    required this.houseNumber,
    required this.moreDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressField(title: 'City', value: city),
            AddressField(title: 'Address', value: address),
            AddressField(title: 'House No.', value: houseNumber),
            AddressField(title: 'More Details', value: moreDetails),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle edit action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit button pressed')),
                  );
                },
                child: const Text('Edit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddressField extends StatelessWidget {
  final String title;
  final String value;

  const AddressField({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}