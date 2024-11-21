import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/auth/login_screen.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.40),
            child: Divider(thickness: 4, color: gray),
          ),
          const SizedBox(height: 24),
          JakartaSans.custom(
              text: 'Pengaturan Akun',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkGray),
          const SizedBox(height: 20),
          InkWell(
            onTap: () async {
              await FlutterSecureStorage().delete(key: 'username');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.exit_to_app, color: black, size: 24),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JakartaSans.custom(
                            text: 'Log Out',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: darkGray),
                        JakartaSans.light(
                            text:
                                'Pastikan untuk log out agar informasi akunmu\ntetap terlindungi',
                            fontSize: 12,
                            maxLines: 2,
                            color: gray),
                      ],
                    )
                  ],
                ),
                Icon(Icons.arrow_forward_ios_outlined, color: black, size: 24),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static void showCustomBottomSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const CustomBottomSheet();
      },
    );
  }
}
