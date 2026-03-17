import 'dart:math';

class ImeiGenerator {
  static const List<String> rbiList = ["01", "10", "30", "33", "35", "44", "45", "49","50", "51", "52","53","54","86","91","98","99"];
  static final random = Random();
  
  const ImeiGenerator();

  static String generateImei() {
    final List<int> randFifteenth = [];
    // Generate 12 random digits
    rbiList[random.nextInt(rbiList.length)].split('').forEach((d) => randFifteenth.add(int.parse(d))); 
    // ignore: avoid_function_literals_in_foreach_calls
    for (int i = 0; i < 12; i++) {
      randFifteenth.add(random.nextInt(10));
    }

    // Luhn Checksum
    int total = 0;
    randFifteenth.asMap().forEach((k,v) {
      if (k % 2 == 1) {
        v *= 2;
        if (v > 9) {
          v -= 9;
        }
      }

      total += v;
    });
 
    randFifteenth.add((10 - (total % 10)) % 10);
    return randFifteenth.join('');
  }
}