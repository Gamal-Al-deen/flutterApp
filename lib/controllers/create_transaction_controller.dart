import 'package:flutter/material.dart';
import '../data/services_data.dart';
import '../data/transactions_data.dart';
import '../models/transaction_model.dart';

class CreateTransactionController extends ChangeNotifier {
  final String serviceId;
  CreateTransactionController(this.serviceId);

  final formKey = GlobalKey<FormState>();
  final notesController = TextEditingController();

  int _currentStep = 0;
  int get currentStep => _currentStep;

  void next() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void back() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void setStep(int i) {
    _currentStep = i;
    notifyListeners();
  }

  Future<TransactionModel?> submit({required String applicantName, required String applicantPhone}) async {
    if (!(formKey.currentState?.validate() ?? false)) return null;
    final service = ServicesData.findById(serviceId);
    if (service == null) return null;
    await Future.delayed(const Duration(milliseconds: 900));
    final now = DateTime.now();
    final ref = 'TRX-${now.year}-${(TransactionsData.all.length + 200).toString().padLeft(5, '0')}';
    final tx = TransactionModel(
      id: 'tx_${now.millisecondsSinceEpoch}',
      referenceNumber: ref,
      serviceId: service.id,
      serviceTitle: service.title,
      serviceIconCode: service.icon.codePoint.toString(),
      serviceColor: service.color,
      status: TransactionStatus.pending,
      submittedAt: now,
      applicantName: applicantName,
      applicantPhone: applicantPhone,
      notes: notesController.text.trim(),
      progress: 15,
      stage: 'تم استلام الطلب',
    );
    TransactionsData.all.insert(0, tx);
    return tx;
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
