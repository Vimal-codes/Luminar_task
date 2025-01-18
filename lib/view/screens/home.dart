import 'package:flutter/material.dart';
import '../../core/dbhelper.dart';
import '../../model/asset_model.dart';
import '../widgets/asset_card.dart';
import 'add_assets.dart';
import 'edit_assets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Asset>> _assetsFuture;

  @override
  void initState() {
    super.initState();
    _assetsFuture = _loadAssets();
  }

  // Fetch assets from the database
  Future<List<Asset>> _loadAssets() async {
    return await DatabaseHelper.instance.queryAllAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.add),
            onSelected: (value) {
              if (value == 'add_asset') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewAssetPage()),
                ).then((_) {
                  // After returning from AddNewAssetPage, refresh the assets
                  setState(() {
                    _assetsFuture = _loadAssets();
                  });
                });
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'add_asset',
                child: Text('Add New Asset'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Asset>>(
        future: _assetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No assets available.'));
          }

          List<Asset> assets = snapshot.data!;
          return ListView.builder(
            itemCount: assets.length,
            itemBuilder: (context, index) {
              Asset asset = assets[index];

              // Check if id is null
              if (asset.id == null) {
                return ListTile(title: Text('Error: Asset ID is null.'));
              }

              return AssetCard(
                name: asset.name,
                type: asset.type,
                description: asset.description,
                isAvailable: asset.availability == 'Available',
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAssetPage(
                        id: asset.id!, // Force unwrapping the id
                        initialName: asset.name,
                        initialType: asset.type,
                        initialDescription: asset.description,
                        initialAvailability: asset.availability,
                      ),
                    ),
                  ).then((_) {
                    // After returning from EditAssetPage, refresh the assets
                    setState(() {
                      _assetsFuture = _loadAssets();
                    });
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
