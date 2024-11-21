import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/genre_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/genre/genre_screen.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/screen/trend/trend_screen.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/services/film/film_services.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/services/genre/genre.services.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/card.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/empty_state.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/error_state.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/loading.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/movie_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> trendMovie;
  late Future<List<MovieModel>> movieThisMonth;
  late Future<List<MovieModel>> movieHighestRank;
  late Future<List<GenreModel>> genres;

  String getCurrentMonthName() {
    final DateFormat dateFormat = DateFormat("MMMM", "id_ID");
    DateTime now = DateTime.now();
    return dateFormat.format(now);
  }

  @override
  void initState() {
    trendMovie = FilmService().getFilmTrend('week', 'all');
    movieThisMonth = FilmService().getFilmThisMonth();
    movieHighestRank = FilmService().getFilmHighestRank();
    genres = GenreService().getGenre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/png/logo.png',
                  fit: BoxFit.cover,
                  width: 30,
                ),
                JakartaSans.bold(text: 'TMBD', fontSize: 20),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_outlined),
                  color: primary,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  color: primary,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SectionTitleWithAction(
                title: 'Trending ',
                subtitle: 'Hari ini',
                actionLabel: 'Lihat Semua',
                widget: TrendScreen()),
            const SizedBox(height: 20),
            MovieListWidget(
              message: 'Sedang tidak ada trend film',
              futureMovies: trendMovie,
              buildCard: (data) {
                String title = data.title ?? data.name ?? "No Title Available";
                String description = data.overview.isNotEmpty
                    ? data.overview
                    : "Description not available\n";
                return CardTrending(
                  id: '${data.id}',
                  backdrop_path: data.backdropPath ?? '',
                  title: title,
                  description: description,
                  score: "${data.voteAverage}",
                );
              },
            ),
            const SizedBox(height: 40),
            SectionTitleWithAction(
              title: 'Baru Rilis ',
              subtitle: getCurrentMonthName(),
              actionLabel: 'Lihat Semua',
            ),
            const SizedBox(height: 16),
            MovieListWidget(
              message:
                  'Sedang tidak ada film baru rilis pada ${getCurrentMonthName()}',
              futureMovies: movieThisMonth,
              buildCard: (data) {
                return CardNewRelease(
                  id: '${data.id}',
                  score: '${data.voteAverage}',
                  posterPath: data.posterPath,
                );
              },
            ),
            const SizedBox(height: 24),
            SectionTitleWithAction(
              title: 'Rating Tertinggi',
              actionLabel: 'Lihat Semua',
            ),
            const SizedBox(height: 16),
            MovieListWidget(
              message: 'Sedang tidak ada film rating tertinggi',
              futureMovies: movieHighestRank,
              buildCard: (data) {
                return CardTopRank(
                  id: '${data.id}',
                  backdrop_path: data.backdropPath ?? '',
                  title: data.title ?? '',
                  date: DateFormat('MMM dd, yyyy')
                      .format(DateTime.parse(data.releaseDate ?? '')),
                  score: '${data.voteAverage}',
                );
              },
            ),
            const SizedBox(height: 24),
            GenreListWidget(genres: genres),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}

class SectionTitleWithAction extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String actionLabel;
  final Widget? widget;

  const SectionTitleWithAction({
    required this.title,
    this.subtitle,
    required this.actionLabel,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              JakartaSans.bold(text: title, fontSize: 18),
              if (subtitle != null)
                JakartaSans.light(text: subtitle!, fontSize: 13, color: gray),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return widget ?? const Placeholder();
              }));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                JakartaSans.regular(
                    text: actionLabel, fontSize: 12, color: primary),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 12, color: primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GenreListWidget extends StatelessWidget {
  final Future<List<GenreModel>> genres;

  const GenreListWidget({required this.genres});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: genres,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressCustom();
        } else if (snapshot.hasError) {
          return const ErrorState();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const EmptyState(
            message: 'Sedang tidak ada genre film',
            widthPicture: 120,
          );
        } else {
          List<GenreModel> genreList = snapshot.data!;
          return ExploreGenresSection(genres: genreList);
        }
      },
    );
  }
}

class ExploreGenresSection extends StatelessWidget {
  final List<GenreModel> genres;

  const ExploreGenresSection({required this.genres});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMarginAuth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JakartaSans.bold(text: 'Jelajahi Film & Serial TV', fontSize: 18),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: genres
                .map(
                  (genre) => InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return GenreScreen(
                          id: '${genre.id}',
                          genre: genre.name,
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: defaultMargin),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderChip),
                      ),
                      child:
                          JakartaSans.regular(text: genre.name, fontSize: 12),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
