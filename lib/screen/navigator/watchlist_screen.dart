import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/card.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_button.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  int selectedCategory = 0;
  bool state = true;

  void updateCategory(int category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void onScrollRefresh() {
    setState(() {
      state = !state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/png/fluent-emoji_eyes.png',
              fit: BoxFit.cover,
              width: 20,
            ),
            JakartaSans.bold(text: 'Watchlist', fontSize: 20),
          ],
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: defaultMarginAuth),
        child: Column(
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
                  text: 'Film',
                  isActive: selectedCategory == 1,
                  onPressed: () => updateCategory(1),
                ),
                const SizedBox(width: 12),
                CustomChip(
                  text: 'Serial TV',
                  isActive: selectedCategory == 2,
                  onPressed: () => updateCategory(2),
                ),
              ],
            ),
            ...List.generate(
              10,
              (index) => const Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CardTrending(
                    id: '94605',
                    backdrop_path: '',
                    title: 'Joker: Folie à Deux',
                    description:
                        "While struggling with his dual identity, Arthur Fleck not only stumbles upon true love, but also finds the music that's always been inside him.",
                    score: "58"),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget emptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMarginAuth),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/png/empty_state.png',
                  width: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 32),
                JakartaSans.light(
                    text:
                        'Watchlistmu masih kosong.\nYuk, tambahkan yang ingin kamu tonton!',
                    fontSize: 14,
                    color: gray,
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
