import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final double? widthPicture;
  const EmptyState({super.key, required this.message, this.widthPicture});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMarginAuth),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/png/empty_state.png',
              width: widthPicture ?? 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            JakartaSans.light(
                text: message,
                fontSize: 12,
                color: gray,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
