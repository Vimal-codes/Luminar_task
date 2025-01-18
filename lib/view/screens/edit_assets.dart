import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/asset_model.dart';
import '../../provider/asset_edit_provider.dart';

class EditAssetPage extends StatefulWidget {
  final int id;
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
  @override
  void initState() {
    super.initState();
    // Initialize the provider values
    final assetEditProvider = Provider.of<AssetEditProvider>(context, listen: false);
    assetEditProvider.name = widget.initialName;
    assetEditProvider.type = widget.initialType;
    assetEditProvider.description = widget.initialDescription;
    assetEditProvider.availability = widget.initialAvailability;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Asset'),
      ),
      body: Consumer<AssetEditProvider>(
        builder: (context, assetEditProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: assetEditProvider.name),
                  onChanged: (value) {
                    assetEditProvider.name = value;
                  },
                  decoration: InputDecoration(labelText: 'Asset Name'),
                ),
                TextField(
                  controller: TextEditingController(text: assetEditProvider.type),
                  onChanged: (value) {
                    assetEditProvider.type = value;
                  },
                  decoration: InputDecoration(labelText: 'Asset Type'),
                ),
                TextField(
                  controller: TextEditingController(text: assetEditProvider.description),
                  onChanged: (value) {
                    assetEditProvider.description = value;
                  },
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                Row(
                  children: [
                    Text('Availability:'),
                    Radio<String>(
                      value: 'Available',
                      groupValue: assetEditProvider.availability,
                      onChanged: (value) {
                        assetEditProvider.availability = value!;
                      },
                    ),
                    Text('Available'),
                    Radio<String>(
                      value: 'Not Available',
                      groupValue: assetEditProvider.availability,
                      onChanged: (value) {
                        assetEditProvider.availability = value!;
                      },
                    ),
                    Text('Not Available'),
                  ],
                ),
                if (assetEditProvider.isLoading) CircularProgressIndicator(),
                if (assetEditProvider.errorMessage.isNotEmpty)
                  Text(
                    'Error: ${assetEditProvider.errorMessage}',
                    style: TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    await assetEditProvider.updateAsset(widget.id);
                    if (!assetEditProvider.isLoading) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update Asset'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
