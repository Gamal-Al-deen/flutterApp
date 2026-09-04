import 'package:flutter/material.dart';
import '../data/transactions_data.dart';
import '../models/transaction_model.dart';

class TransactionsController extends ChangeNotifier {
  TransactionStatus? _filter;
  TransactionStatus? get filter => _filter;

  String _query = '';
  String get query => _query;

  void setFilter(TransactionStatus? f) {
    _filter = f;
    notifyListeners();
  }

  void updateQuery(String q) {
    _query = q;
    notifyListeners();
  }

  void clear() {
    _query = '';
    _filter = null;
    notifyListeners();
  }

  List<TransactionModel> get filtered {
    Iterable<TransactionModel> list = TransactionsData.all;
    if (_filter != null) {
      list = list.where((t) => t.status == _filter);
    }
    if (_query.trim().isNotEmpty) {
      final q = _query.trim();
      list = list.where((t) =>
          t.referenceNumber.contains(q) ||
          t.serviceTitle.contains(q) ||
          t.applicantName.contains(q));
    }
    return list.toList();
  }

  int countOf(TransactionStatus? s) {
    if (s == null) return TransactionsData.all.length;
    return TransactionsData.all.where((t) => t.status == s).length;
  }
}
