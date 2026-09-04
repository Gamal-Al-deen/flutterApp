import 'package:flutter/material.dart';
import '../data/services_data.dart';
import '../data/transactions_data.dart';
import '../models/service_model.dart';
import '../models/transaction_model.dart';

class HomeController extends ChangeNotifier {
  String _query = '';
  String get query => _query;

  void updateQuery(String q) {
    _query = q;
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }

  List<ServiceModel> get featured => ServicesData.featured;

  List<ServiceModel> get searchResults {
    if (_query.trim().isEmpty) return const [];
    final q = _query.trim();
    return ServicesData.all
        .where((s) =>
            s.title.contains(q) ||
            s.shortDescription.contains(q) ||
            s.category.label.contains(q))
        .toList();
  }

  int get activeTransactionsCount => TransactionsData.all
      .where((t) =>
          t.status == TransactionStatus.pending ||
          t.status == TransactionStatus.processing ||
          t.status == TransactionStatus.approved)
      .length;
}
