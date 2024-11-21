import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';

class CircularProgressCustom extends StatelessWidget {
  const CircularProgressCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: primary),
    );
  }
}
