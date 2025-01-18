import 'package:flutter/material.dart';

import '../../core/dbhelper.dart';
import '../../model/asset_model.dart';

class AddNewAssetPage extends StatefulWidget {
  @override
  _AddNewAssetPageState createState() => _AddNewAssetPageState();
}

class _AddNewAssetPageState extends State<AddNewAssetPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _availability = 'Available';

  void _handleAvailabilityChange(String? value) {
    setState(() {
      _availability = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Asset'),
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
                // Create a new Asset object with the input data
                Asset newAsset = Asset(
                  name: _nameController.text,
                  type: _typeController.text,
                  description: _descriptionController.text,
                  availability: _availability,
                );

                // Insert into the database
                await DatabaseHelper.instance.insert(newAsset);

                // Navigate back to the HomePage and refresh the data
                Navigator.pop(context);
              },
              child: Text('Add Asset'),
            )

          ],
        ),
      ),
    );
  }
}
