import 'package:flutter/material.dart';
import '../data/services_data.dart';
import '../models/service_model.dart';

class ServicesController extends ChangeNotifier {
  ServiceCategory? _selected;
  ServiceCategory? get selected => _selected;

  String _query = '';
  String get query => _query;

  void select(ServiceCategory? category) {
    _selected = category;
    notifyListeners();
  }

  void updateQuery(String q) {
    _query = q;
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }

  void clear() {
    _query = '';
    _selected = null;
    notifyListeners();
  }

  List<ServiceModel> get filtered {
    Iterable<ServiceModel> list = ServicesData.all;
    if (_selected != null) {
      list = list.where((s) => s.category == _selected);
    }
    if (_query.trim().isNotEmpty) {
      final q = _query.trim();
      list = list.where((s) =>
          s.title.contains(q) ||
          s.shortDescription.contains(q) ||
          s.category.label.contains(q));
    }
    return list.toList();
  }

  int countOf(ServiceCategory? c) {
    if (c == null) return ServicesData.all.length;
    return ServicesData.all.where((s) => s.category == c).length;
  }
}
