import 'package:flutter/material.dart';
import '../data/transactions_data.dart';
import '../models/transaction_model.dart';

class TransactionDetailsController extends ChangeNotifier {
  final String transactionId;
  TransactionDetailsController(this.transactionId);

  TransactionModel? get transaction {
    try {
      return TransactionsData.all
          .firstWhere((t) => t.id == transactionId);
    } catch (_) {
      return null;
    }
  }
}
