String formatCurrency(double value) {
  final parts = value.toStringAsFixed(2).split('.');
  final digits = parts.first;
  final buffer = StringBuffer();

  for (var index = 0; index < digits.length; index++) {
    final digitsToRight = digits.length - index;
    buffer.write(digits[index]);
    if (digitsToRight > 1 && digitsToRight % 3 == 1) {
      buffer.write('.');
    }
  }

  return 'R\$ ${buffer.toString()},${parts.last}';
}
