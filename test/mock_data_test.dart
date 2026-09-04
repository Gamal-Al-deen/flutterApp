import 'package:flutter_test/flutter_test.dart';
import 'package:muamalat/data/services_data.dart';
import 'package:muamalat/data/transactions_data.dart';
import 'package:muamalat/data/notifications_data.dart';
import 'package:muamalat/data/users_data.dart';

void main() {
  test('Services mock data is not empty', () {
    expect(ServicesData.all.isNotEmpty, true);
    expect(ServicesData.featured.isNotEmpty, true);
  });

  test('Service lookup by id works', () {
    final s = ServicesData.findById('srv_001');
    expect(s, isNotNull);
    expect(s!.title.isNotEmpty, true);
  });

  test('Transactions mock data is not empty', () {
    expect(TransactionsData.all.isNotEmpty, true);
  });

  test('Notifications mock data is not empty', () {
    expect(NotificationsData.all.isNotEmpty, true);
  });

  test('Demo user has required fields', () {
    expect(UsersData.demo.name.isNotEmpty, true);
    expect(UsersData.demo.email.isNotEmpty, true);
  });
}
