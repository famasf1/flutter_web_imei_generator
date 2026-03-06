import 'dart:math';

class ImeiGenerator {
  const ImeiGenerator();

  static String generateImei() {
    final List<String> rbi_list = ["01", "10", "30", "33", "35", "44", "45", "49","50", "51", "52","53","54","86","91","98","99"];
    List<int> rand_twelve = [];
    // Generate 12 random digits
    final digits = rbi_list[Random().nextInt(rbi_list.length - 1)];

    rand_twelve.add(int.parse(digits));
    for (int i = 0; i < 12; i++) {
      rand_twelve.add(Random().nextInt(9));
    }

    // Luhn Checksum
    int total = 0;
    rand_twelve.asMap().forEach((k,v) {
      if (k % 2 == 1) {
        v *= 2;
        if (v > 9) {
          v -= 9;
        }
      }

      total += v;
    });

    final check = (10 - (total % 10)) % 10;
    rand_twelve.add(check);

    return rand_twelve.join('');
  }
}