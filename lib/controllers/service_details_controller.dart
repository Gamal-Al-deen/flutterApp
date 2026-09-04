import 'package:flutter/material.dart';
import '../data/services_data.dart';
import '../models/service_model.dart';

class ServiceDetailsController extends ChangeNotifier {
  final String serviceId;
  ServiceDetailsController(this.serviceId);

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  ServiceModel? get service => ServicesData.findById(serviceId);

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
