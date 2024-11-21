import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/detail_movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/services/detail_service.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/card.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_button.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/default_floating_action_button.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/empty_state.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/loading.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/user_score.dart';

class DetailFilmScreen extends StatefulWidget {
  final String id;
  const DetailFilmScreen({super.key, required this.id});

  @override
  State<DetailFilmScreen> createState() => _DetailFilmScreenState();
}

class _DetailFilmScreenState extends State<DetailFilmScreen> {
  bool isWatchlist = false;
  late Future<DetailFilmModel> movieDetail;

  final Map<String, dynamic> profile = {
    'Director, Writer': 'Todd Phillips',
    'Writer': 'Scott Silver',
    'Characters': [
      'Bill Finger',
      'Paul Dini',
      'Bob Kane',
      'Bruce Timm',
      'Jerry Robinson'
    ],
  };

  String formatRuntime(int runtime) {
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;
    return "$hours jam $minutes menit";
  }

  String roundToOneDecimal(double number) {
    double rounded = (number * 10).roundToDouble();
    return rounded % 1 == 0 ? rounded.toInt().toString() : rounded.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetail = DetailFetch().getDetailMovie(widget.id);
    print('id : ${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: const DefaultFloatingActionButton(),
        body: FutureBuilder<DetailFilmModel>(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressCustom();
              } else if (snapshot.hasError) {
                return const Center(
                    child: EmptyState(message: 'Terjadi Kesalahan Internal'));
              } else if (snapshot.hasData) {
                DetailFilmModel movie = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              'https://image.tmdb.org/t/p/original${movie.belongsToCollection['backdrop_path']}',
                              height: screenHeight * 0.45,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else if (loadingProgress.expectedTotalBytes !=
                                        null &&
                                    loadingProgress.cumulativeBytesLoaded ==
                                        loadingProgress.expectedTotalBytes) {
                                  return child;
                                } else if (loadingProgress.expectedTotalBytes !=
                                        null &&
                                    loadingProgress.cumulativeBytesLoaded >
                                        loadingProgress.expectedTotalBytes!) {
                                  return Container(
                                    color: Colors.grey[400],
                                    height: screenHeight * 0.45,
                                    width: screenWidth,
                                    child: Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    color: white,
                                    height: screenHeight * 0.45,
                                    width: screenWidth,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: primary,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Container(
                                  color: Colors.grey[400],
                                  height: screenHeight * 0.45,
                                  width: screenWidth,
                                );
                              },
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                            height: screenHeight * 0.45,
                            width: screenWidth,
                          ),
                          Positioned(
                            bottom: 24,
                            left: 24,
                            right: 24,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                JakartaSans.bold(
                                    text: movie.title,
                                    fontSize: 20,
                                    color: white),
                                const SizedBox(height: 8),
                                JakartaSans.light(
                                  text: movie.genres
                                      .map((genre) => genre.name)
                                      .join(', '),
                                  fontSize: 10,
                                  color: softgray,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: softgray),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        padding: const EdgeInsets.all(4),
                                        child: Center(
                                          child: JakartaSans.light(
                                              text: 'R',
                                              fontSize: 10,
                                              color: softgray),
                                        )),
                                    const SizedBox(width: 8),
                                    _MovieDetailItem(
                                        movie.releaseDate, softgray),
                                    const SizedBox(width: 8),
                                    _MovieDetailItem(
                                      movie.originCountry
                                          .map((country) => (country))
                                          .join(", "),
                                      softgray,
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.circle,
                                        size: 4, color: softgray),
                                    const SizedBox(width: 8),
                                    _MovieDetailItem(
                                        formatRuntime(movie.runtime), softgray),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomButtonIcon(
                                          onPressed: () {},
                                          text: 'Lihat Trailer',
                                          icon: Icons.arrow_right_rounded,
                                          colorIcon: white,
                                          bgColor: primary),
                                      const SizedBox(width: 4),
                                      _WatchlistButton(),
                                      const SizedBox(width: 4),
                                      UserScoreLG(
                                          score:
                                              '${roundToOneDecimal(movie.voteAverage)}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMarginAuth,
                            vertical: defaultMarginAuth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            JakartaSans.bold(
                                text: 'Gambaran Umum', fontSize: 14),
                            const SizedBox(height: 8),
                            JakartaSans.light(
                              text: movie.overview,
                              fontSize: 12,
                              textAlign: TextAlign.start,
                              color: gray,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMarginAuth),
                        child: Divider(color: softgray),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMarginAuth),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.width * 0.1,
                            childAspectRatio: 3,
                          ),
                          itemCount: calculateItemCount(),
                          itemBuilder: (context, index) {
                            return ProfileItem(index);
                          },
                        ),
                      ),
                      Container(
                        color: white,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultMarginAuth),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  JakartaSans.bold(
                                      text: 'Pemeran & Kru', fontSize: 18),
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        JakartaSans.regular(
                                            text: 'Lihat Semua',
                                            fontSize: 12,
                                            color: primary),
                                        const SizedBox(width: 4),
                                        Icon(Icons.arrow_forward_ios,
                                            size: 12, color: primary),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const SizedBox(width: defaultMarginAuth),
                                  ...List.generate(10, (index) {
                                    return const Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: CardCrew(
                                          realName: 'Joaquin Phoenix',
                                          charName: 'Arthur Fleck'),
                                    );
                                  })
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMarginAuth),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.width * 0.1,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3.2,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final List<Map<String, String>> details = [
                              {'Status': movie.status},
                              {
                                'Bahasa Ucapan': movie.originalLanguage,
                              },
                              {'Anggaran': '\$${movie.budget}'},
                              {'Pemasukan': '\$${movie.revenue}'}
                            ];
                            final detail = details[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                JakartaSans.light(
                                    text: detail.keys.first,
                                    fontSize: 10,
                                    color: gray),
                                const SizedBox(height: 4),
                                JakartaSans.regular(
                                    text: detail.values.first,
                                    fontSize: 12,
                                    color: black),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMarginAuth,
                            vertical: defaultMarginAuth),
                        child: JakartaSans.bold(text: 'Ulasan', fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: defaultMarginAuth),
                            ...List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: CardComment(
                                  title: 'Title ${index + 1}',
                                  date: '25 November 2023',
                                  description:
                                      "one of the best installments to the Hunger Games series. it’s definitely the darkest and most political entry to the saga. act III could have been more fleshed out, but it doesn’t detract from the story the film is telling. act III was the most compelling segments in aspects of Coriolanus Snow’s villain origins. \n\nif you're a fan of political dramas or a character study or just a huge fan of the Hunger Games series, this is the film for you. excellent casting, excellent music, and deliciously evil performances.",
                                  score: "8.0",
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const EmptyState(message: 'Terjadi Kesalahan Teknis');
              }
            }));
  }

  Widget MovieDetails() {
    return Row(
      children: [
        _MovieDetailItem('R', softgray),
        const SizedBox(width: 8),
        _MovieDetailItem('15/12/2023', softgray),
        const SizedBox(width: 8),
        _MovieDetailItem('(ID)', softgray),
        const SizedBox(width: 8),
        Icon(Icons.circle, size: 4, color: softgray),
        const SizedBox(width: 8),
        _MovieDetailItem('2 jam 18 menit', softgray),
      ],
    );
  }

  Widget _MovieDetailItem(String text, Color color) {
    return JakartaSans.light(text: text, fontSize: 10, color: color);
  }

  Widget _WatchlistButton() {
    return CustomButtonIcon(
      onPressed: _toggleWatchlist,
      text: 'Watchlist',
      icon: isWatchlist ? Icons.check_circle : Icons.add,
      colorIcon: isWatchlist ? green : white,
      bgColor: Colors.white.withOpacity(0.25),
      sideColor: isWatchlist ? green : Colors.transparent,
    );
  }

  void _toggleWatchlist() {
    setState(() {
      isWatchlist = !isWatchlist;
    });
  }

  int calculateItemCount() {
    int count = profile.entries.length - 1;
    count += (profile['Characters'] as List).length;
    return count;
  }

  Widget ProfileItem(int index) {
    if (index < profile.entries.length - 1) {
      final entry = profile.entries.elementAt(index);
      if (entry.value is String) {
        return KeyValueItem(entry.key, entry.value);
      } else if (entry.value is List<String>) {
        return const SizedBox.shrink();
      }
    } else {
      final charactersIndex = index - (profile.entries.length - 1);
      return KeyValueItem('Characters', profile['Characters'][charactersIndex]);
    }
    return const SizedBox();
  }

  Widget KeyValueItem(String key, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JakartaSans.light(text: key, fontSize: 10, color: gray),
        const SizedBox(height: 4),
        JakartaSans.regular(text: value, fontSize: 12, color: black),
      ],
    );
  }
}
