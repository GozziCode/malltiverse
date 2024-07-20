import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    StringBuffer newText = StringBuffer();

    // Ensure the text does not exceed 12 digits
    int maxLength = 16;
    String digitsOnly =
        text.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    String truncated = digitsOnly.length <= maxLength
        ? digitsOnly
        : digitsOnly.substring(0, maxLength);

    for (int i = 0; i < truncated.length; i++) {
      if (i % 4 == 0 && i != 0) {
        newText.write(' '); // Add a space every four characters
      }
      newText.write(truncated[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
