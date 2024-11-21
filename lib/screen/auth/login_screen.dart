import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/navigator/main_menu.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_button.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Color emailFieldColor = Colors.white;
  Color passwordFieldColor = Colors.white;

  final storage = const FlutterSecureStorage();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateAndLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: JakartaSans.light(
            text: 'Isi form yang dibutuhkan',
            fontSize: 14,
            color: textSnackbar,
          ),
          backgroundColor: bgSnackbar,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.88,
              left: 30,
              right: 30),
        ),
      );
    } else if (formKey.currentState?.validate() ?? false) {
      await storage.write(key: 'username', value: 'a');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const MainMenu(id: 0)),
          (Route<dynamic> route) => false);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            // bg
            Opacity(
              opacity: 0.50,
              child: Image.asset(
                'assets/png/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMarginAuth)
                  .add(EdgeInsets.only(top: screenHeight * 0.1)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    Image.asset(
                      'assets/png/logo.png',
                      width: 96,
                      fit: BoxFit.cover,
                    ),
                    JakartaSans.custom(
                        text: 'TMDB',
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: black),
                    const SizedBox(height: 32),
                    JakartaSans.light(
                        text:
                            'Siap-siaplah untuk terjun ke dalam kisah-kisah terhebat di TV dan Film',
                        fontSize: 14,
                        textAlign: TextAlign.center,
                        color: black),
                    const SizedBox(height: 32),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            labelText: 'Alamat Email',
                            validator: (value) {
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: passwordController,
                            labelText: 'Password',
                            isPassword: true,
                            validator: (value) {
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            onPressed: validateAndLogin,
                            text: 'Login',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                            endIndent: 10,
                          ),
                        ),
                        JakartaSans.light(text: 'atau', fontSize: 10),
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomButtonBorder(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MainMenu(id: 0)),
                              (Route<dynamic> route) => false);
                        },
                        text: 'Masuk Sebagai Tamu'),
                    const SizedBox(height: 24),
                    RichText(
                      text: TextSpan(
                        style: primaryTextStyle.copyWith(),
                        children: [
                          TextSpan(
                              text:
                                  'Dengan membuat akun atau masuk, Anda setuju dengan ',
                              style: secondaryTextStyle.copyWith()),
                          TextSpan(
                            text: "Ketentuan Layanan ",
                            style: customTextStyle.copyWith(
                              color: primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                              text: 'dan ',
                              style: secondaryTextStyle.copyWith()),
                          TextSpan(
                            text: 'Kebijakan Privasi ',
                            style: customTextStyle.copyWith(
                              color: primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                              text: 'kami',
                              style: secondaryTextStyle.copyWith()),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
