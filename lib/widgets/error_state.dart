import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMarginAuth),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_outlined, size: 64, color: primary),
            const SizedBox(height: 8),
            JakartaSans.light(
                text: 'Sedang Terjadi Kesalahan Sistem',
                fontSize: 14,
                color: gray,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
