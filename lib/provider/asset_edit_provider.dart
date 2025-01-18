import 'package:flutter/material.dart';
import '../../core/dbhelper.dart';
import '../../model/asset_model.dart';

class AssetEditProvider with ChangeNotifier {
  String _name = '';
  String _type = '';
  String _description = '';
  String _availability = 'Available';
  bool _isLoading = false;
  String _errorMessage = '';

  String get name => _name;
  String get type => _type;
  String get description => _description;
  String get availability => _availability;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set type(String value) {
    _type = value;
    notifyListeners();
  }

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  set availability(String value) {
    _availability = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  Future<void> updateAsset(int id) async {
    try {
      isLoading = true;
      Asset updatedAsset = Asset(
        id: id,
        name: _name,
        type: _type,
        description: _description,
        availability: _availability,
      );
      await DatabaseHelper.instance.update(updatedAsset);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }
}
