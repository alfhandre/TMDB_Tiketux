import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/auth/login_screen.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/card.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_bottom_sheet.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool state = true;
  final storage = const FlutterSecureStorage();
  String username = '';

  void onScrollRefresh() {
    setState(() {
      state = !state;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    String? storedUsername = await storage.read(key: 'username');
    setState(() {
      username = storedUsername ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          color: primary,
          onRefresh: () async {
            onScrollRefresh();
          },
          child: state ? content() : emptyState()),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultMarginAuth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    username.isNotEmpty
                        ? Image.asset(
                            'assets/png/profile_logo.png',
                            width: 64,
                            fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            backgroundColor: const Color(0xffD9D9D9),
                            radius: 32,
                            child: Center(
                                child:
                                    Icon(Icons.person, color: gray, size: 24)),
                          ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JakartaSans.custom(
                            text: username.isNotEmpty
                                ? 'ilhamrajab'
                                : 'Tiketux TMBD',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: black),
                        username.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    JakartaSans.light(
                                        text: 'iamidat@outlook.com',
                                        fontSize: 10,
                                        color: gray),
                                    JakartaSans.light(
                                        text: 'Bergabung sejak November 2023',
                                        fontSize: 10,
                                        color: gray),
                                  ])
                            : JakartaSans.light(
                                text: 'tiketux', fontSize: 10, color: gray),
                      ],
                    ),
                  ],
                ),
                username.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          CustomBottomSheet.showCustomBottomSheet(
                            context: context,
                          );
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: softgray,
                            ),
                          ),
                          child: Icon(
                            Icons.more_horiz_outlined,
                            color: gray,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            username.isNotEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: CustomButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        },
                        text: 'Login'),
                  ),
            const SizedBox(height: 28),
            JakartaSans.bold(text: 'Terakhir dilihat', fontSize: 18),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const CardNewRelease(
                  score: '80',
                  posterPath: '',
                  id: '1  ',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyState() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            username.isNotEmpty
                ? Image.asset(
                    'assets/png/profile_logo.png',
                    width: 64,
                    fit: BoxFit.cover,
                  )
                : CircleAvatar(
                    backgroundColor: const Color(0xffD9D9D9),
                    radius: 32,
                    child: Center(
                        child: Icon(Icons.person, color: gray, size: 24)),
                  ),
            const SizedBox(height: 12),
            JakartaSans.custom(
                text: username.isNotEmpty ? 'ilhamrajab' : 'Tiketux TMDB',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: black),
            JakartaSans.light(
                text: username.isNotEmpty ? 'iamidat@outlook.com' : 'tiketux',
                fontSize: 10,
                color: gray),
            username.isNotEmpty
                ? JakartaSans.light(
                    text: 'Bergabung sejak November 2023',
                    fontSize: 10,
                    color: gray)
                : Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: MediaQuery.of(context).size.width * 0.35),
                    child: CustomButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        },
                        text: 'Login'),
                  ),
            const SizedBox(height: 12),
            username.isNotEmpty
                ? InkWell(
                    onTap: () {
                      CustomBottomSheet.showCustomBottomSheet(
                        context: context,
                      );
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: softgray,
                        ),
                      ),
                      child: Icon(
                        Icons.more_horiz_outlined,
                        color: gray,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
