import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';

class UserScoreLG extends StatelessWidget {
  final String score;
  const UserScoreLG({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: chocolate,
            size: 16,
          ),
          JakartaSans.bold(text: score, fontSize: 12, color: chocolate),
          JakartaSans.bold(text: '%', fontSize: 8, color: chocolate),
        ],
      ),
    );
  }
}

class UserScoreMD extends StatelessWidget {
  final String score;
  const UserScoreMD({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.5, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.star,
              color: chocolate,
              size: 16,
            ),
            JakartaSans.bold(text: score, fontSize: 12, color: chocolate),
            JakartaSans.bold(text: '%', fontSize: 8, color: chocolate),
          ],
        ),
      ),
    );
  }
}

class UserScoreSM extends StatelessWidget {
  final String score;
  const UserScoreSM({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.5, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.star,
              color: chocolate,
              size: 16,
            ),
            JakartaSans.bold(text: score, fontSize: 12, color: chocolate),
          ],
        ),
      ),
    );
  }
}

class UserScorePrecentateSM extends StatelessWidget {
  final String score;
  const UserScorePrecentateSM({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.5, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.star,
              color: chocolate,
              size: 16,
            ),
            JakartaSans.bold(text: score, fontSize: 12, color: chocolate),
            JakartaSans.bold(text: '%', fontSize: 8, color: chocolate),
          ],
        ),
      ),
    );
  }
}
