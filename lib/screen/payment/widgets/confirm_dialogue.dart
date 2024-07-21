import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationDialog extends StatelessWidget {
  final String totalAmount;
  final String address;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.totalAmount,
    required this.address,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirm Order',
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Amount: $totalAmount',
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Address: $address',
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'Confirm',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
