import 'package:flutter_test/flutter_test.dart';
import 'package:imei_generator_flutter_web/imei.dart';

void main() {
  List<String> imeiTest = [];

  bool _isValidImei(String imei) {
    if (!RegExp(r'^\d{15}$').hasMatch(imei)) {
      return false;
    }

    final digits = imei.split('').map(int.parse).toList();
    var sum = 0;

    for (var i = 0; i < 14; i++) {
      var digit = digits[i];

      if (i.isOdd) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }

      sum += digit;
    }

    final expectedCheckDigit = (10 - (sum % 10)) % 10;
    return digits[14] == expectedCheckDigit;
  }

  setUp(() {
    for (var i = 0; i < 10; i++) {
      imeiTest.add(ImeiGenerator.generateImei());
    }
  });

  test('IMEI test', () {
    final imei = ImeiGenerator.generateImei();
    expect(_isValidImei(imei), isTrue, reason: "Generated IMEI was $imei");
  });

  test('Performance', () {
    const iteration = 10000;

    for (var i = 0; i < 100; i++) {
      ImeiGenerator.generateImei();
    }

    final stopwatch = Stopwatch()..start();

    for (var i = 0; i < iteration; i++) {
      ImeiGenerator.generateImei();
    }

    stopwatch.stop();

    print("Generated $iteration IMEIs in ${stopwatch.elapsedMilliseconds} ms");
    expect(stopwatch.elapsedMilliseconds, lessThan(100));
  });
}