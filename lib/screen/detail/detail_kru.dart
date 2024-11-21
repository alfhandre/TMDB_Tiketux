import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/card.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_button.dart';

class DetailKruScreen extends StatefulWidget {
  const DetailKruScreen({super.key});

  @override
  State<DetailKruScreen> createState() => _DetailKruScreenState();
}

class _DetailKruScreenState extends State<DetailKruScreen> {
  int selectedCategory = 0;

  void updateCategory(int category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JakartaSans.regular(text: 'Pemeran & Kru', fontSize: 14),
            JakartaSans.regular(
                text: 'Pemeran & Kru', fontSize: 12, color: gray),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultMarginAuth, vertical: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomChip(
                    text: 'Semua',
                    isActive: selectedCategory == 0,
                    onPressed: () => updateCategory(0),
                  ),
                  const SizedBox(width: 12),
                  CustomChip(
                    text: 'Pemeran',
                    isActive: selectedCategory == 1,
                    onPressed: () => updateCategory(1),
                  ),
                  const SizedBox(width: 12),
                  CustomChip(
                    text: 'Kru',
                    isActive: selectedCategory == 2,
                    onPressed: () => updateCategory(2),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  JakartaSans.bold(text: 'Pemeran', fontSize: 18),
                  const SizedBox(width: 4),
                  JakartaSans.light(text: '5', fontSize: 13, color: gray),
                ],
              ),
              const SizedBox(height: 12),
              CardCrewDetail(realName: 'realName', asA: "castName"),
              const SizedBox(height: 24),
              Row(
                children: [
                  JakartaSans.bold(text: 'Kru', fontSize: 18),
                  const SizedBox(width: 4),
                  JakartaSans.light(text: '5', fontSize: 13, color: gray),
                ],
              ),
              const SizedBox(height: 12),
              JakartaSans.custom(
                  text: 'Bidang',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkGray),
              const SizedBox(height: 12),
              CardCrewDetail(realName: 'realName', asA: 'castName')
            ],
          ),
        ),
      ),
    );
  }
}
