import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/navigator/beranda_screen.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/navigator/profile_screen.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/navigator/watchlist_screen.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';

class MainMenu extends StatefulWidget {
  final int id;
  const MainMenu({super.key, required this.id});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int bottomNavIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    WatchlistScreen(),
    ProfileScreen(),
  ];

  void onBarTapped(int index) {
    setState(() {
      bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    bottomNavIndex = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: pages[bottomNavIndex]),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: softgray),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonNavBarCustom(
                        icon: bottomNavIndex == 0
                            ? Icons.home_rounded
                            : Icons.home_outlined,
                        namePage: 'Beranda',
                        isActive: bottomNavIndex == 0,
                        onTap: () {
                          onBarTapped(0);
                        }),
                    const SizedBox(width: 12),
                    ButtonNavBarCustom(
                        icon: bottomNavIndex == 1
                            ? Icons.archive_rounded
                            : Icons.archive_outlined,
                        namePage: 'Watchlist',
                        isActive: bottomNavIndex == 1,
                        onTap: () {
                          onBarTapped(1);
                        }),
                    const SizedBox(width: 12),
                    ButtonNavBarCustom(
                        icon: bottomNavIndex == 2
                            ? Icons.person
                            : Icons.person_outline,
                        namePage: 'Profil',
                        isActive: bottomNavIndex == 2,
                        onTap: () {
                          onBarTapped(2);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonNavBarCustom extends StatelessWidget {
  final String namePage;
  final IconData icon;
  final bool isActive;
  final void Function() onTap;

  const ButtonNavBarCustom({
    super.key,
    required this.namePage,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticOut,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? primary : Colors.transparent,
          borderRadius: isActive ? BorderRadius.circular(999) : null,
        ),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Icon(
                icon,
                key: ValueKey<bool>(isActive),
                color: isActive ? white : primary,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: isActive
                  ? Row(
                      key: const ValueKey<bool>(true),
                      children: [
                        const SizedBox(width: 6),
                        JakartaSans.regular(
                          text: namePage,
                          fontSize: 12,
                          color: white,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
