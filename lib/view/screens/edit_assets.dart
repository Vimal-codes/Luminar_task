import 'package:flutter/material.dart';

import '../../core/dbhelper.dart';
import '../../model/asset_model.dart';

class EditAssetPage extends StatefulWidget {
  final int id;  // Change to int for asset ID
  final String initialName;
  final String initialType;
  final String initialDescription;
  final String initialAvailability;

  EditAssetPage({
    required this.id,
    required this.initialName,
    required this.initialType,
    required this.initialDescription,
    required this.initialAvailability,
  });

  @override
  _EditAssetPageState createState() => _EditAssetPageState();
}

class _EditAssetPageState extends State<EditAssetPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _availability = '';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _typeController.text = widget.initialType;
    _descriptionController.text = widget.initialDescription;
    _availability = widget.initialAvailability;
  }

  void _handleAvailabilityChange(String? value) {
    setState(() {
      _availability = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Asset Name'),
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Asset Type'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            Row(
              children: [
                Text('Availability:'),
                Radio<String>(
                  value: 'Available',
                  groupValue: _availability,
                  onChanged: _handleAvailabilityChange,
                ),
                Text('Available'),
                Radio<String>(
                  value: 'Not Available',
                  groupValue: _availability,
                  onChanged: _handleAvailabilityChange,
                ),
                Text('Not Available'),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                // Correct the issue by passing the `id` as an int
                Asset updatedAsset = Asset(
                  id: widget.id, // Pass the `id` from the constructor
                  name: _nameController.text,
                  type: _typeController.text,
                  description: _descriptionController.text,
                  availability: _availability,
                );
                await DatabaseHelper.instance.update(updatedAsset);
                Navigator.pop(context);
              },
              child: Text('Update Asset'),
            ),
          ],
        ),
      ),
    );
  }
}
