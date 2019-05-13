import 'package:flutter_test/flutter_test.dart';
import 'package:spent/utils/date_time.dart';

void main() {
  test('should return the formatted date correctly', () {
    DateTime testDate = DateTime(2019, 5, 31);

    expect(formatDate(testDate), '31 May, 2019');
  });
}
