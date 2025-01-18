import 'package:asset_man/view/screens/edit_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/asset_edit_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => AssetEditProvider(),
        child: EditAssetPage(
          id: 1, // Provide actual asset ID
          initialName: 'Laptop',
          initialType: 'Electronics',
          initialDescription: 'A work laptop',
          initialAvailability: 'Available',
        ),
      ),
    );
  }
}
