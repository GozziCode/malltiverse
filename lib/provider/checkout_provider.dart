import 'package:flutter/material.dart';

class CheckoutProvider with ChangeNotifier {
  String _deliveryAddress = '';
  String _contact1 = '';
  String _contact2 = '';
  String? _pickupValue;

  // Getters and setters for the properties
  String get deliveryAddress => _deliveryAddress;
  set deliveryAddress(String value) {
    _deliveryAddress = value;
    if (value.isNotEmpty) {
      _pickupValue = null;
    }
    notifyListeners();
  }

  String get contact1 => _contact1;
  set contact1(String value) {
    _contact1 = value;
    notifyListeners();
  }

  String get contact2 => _contact2;
  set contact2(String value) {
    _contact2 = value;
    notifyListeners();
  }

  String? get pickupValue => _pickupValue;
  set pickupValue(String? value) {
    _pickupValue = value;
    if (value != null) {
      _deliveryAddress = '';
    }
    notifyListeners();
  }

  String getFinalAddress() {
    if (_pickupValue == 'pickup1') {
      return 'Pickup at Sokoto Street, Area 1, Garki Area 1 AMAC';
    } else if (_pickupValue == 'pickup2') {
      return 'Pickup at Old Secretariat Complex, Area 1, Garki Abaji Abaji';
    } else {
      return _deliveryAddress;
    }
  }

  // Method to reset all fields
  void reset() {
    _deliveryAddress = '';
    _contact1 = '';
    _contact2 = '';
    _pickupValue = null;
    notifyListeners();
  }
}
