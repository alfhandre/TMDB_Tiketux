import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/theme.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/utils/text_plus_jakarta_sans.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/card.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/custom_button.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/widgets/empty_state.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/providers/movie_provider.dart';

class TrendScreen extends StatefulWidget {
  const TrendScreen({super.key});

  @override
  _TrendScreenState createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen> {
  int selectedCategory = 0;
  String type = 'all';

  void updateCategory(int category) {
    setState(() {
      selectedCategory = category;

      if (category == 1) {
        type = 'movie';
      } else if (category == 2) {
        type = 'tv';
      } else {
        type = 'all';
      }
      Provider.of<MovieProvider>(context, listen: false).fetchMovies(type);
    });
  }

  @override
  void initState() {
    Provider.of<MovieProvider>(context, listen: false).fetchMovies('all');
    context.read<MovieProvider>().fetchMovies('all');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: JakartaSans.regular(
          text: 'Trend Hari Ini',
          fontSize: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
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
              const SizedBox(height: 24),
              Consumer<MovieProvider>(
                builder: (context, movieProvider, child) {
                  if (movieProvider.trendMovies.isEmpty) {
                    return const EmptyState(
                      message: 'Sedang tidak ada trend film',
                      widthPicture: 120,
                    );
                  }

                  List<MovieModel> movies = movieProvider.trendMovies;

                  return Column(
                    children: [
                      ...movies.map((data) {
                        String title =
                            data.title ?? data.name ?? "No Title Available";
                        String description = data.overview.isNotEmpty
                            ? data.overview
                            : "Description not available\n";
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CardTrending(
                            id: '${data.id}',
                            width: 1,
                            backdrop_path: data.backdropPath ?? '',
                            title: title,
                            description: description,
                            score: "${data.voteAverage}",
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
