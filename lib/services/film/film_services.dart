import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tdbd_trans_berjaya_khatulistiwa/models/movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/url.dart';

class FilmService {
  String getFirstAndLastDateOfMonth(int month, int year) {
    DateTime firstDate = DateTime(year, month, 1);
    DateTime lastDate = DateTime(year, month + 1, 0);
    String gte =
        '${firstDate.year}-${firstDate.month.toString().padLeft(2, '0')}-${firstDate.day.toString().padLeft(2, '0')}';
    String lte =
        '${lastDate.year}-${lastDate.month.toString().padLeft(2, '0')}-${lastDate.day.toString().padLeft(2, '0')}';

    return '$gte,$lte';
  }

  Future<List<MovieModel>> getFilmTrend(String date, String type) async {
    try {
      final res = await http.get(
        Uri.parse('${Url().val}trending/$type/$date${Url().apiKey}'),
      );

      final List<dynamic> data = json.decode(res.body)['results'];
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<MovieModel>> getFilmThisMonth() async {
    try {
      DateTime now = DateTime.now();
      String gte =
          getFirstAndLastDateOfMonth(now.month, now.year).split(',')[0];
      String lte =
          getFirstAndLastDateOfMonth(now.month, now.year).split(',')[1];

      final res = await http.get(
        Uri.parse(
            '${Url().val}discover/movie${Url().apiKey}&primary_release_date.gte=$gte&primary_release_date.lte=$lte'),
      );

      final List<dynamic> data = json.decode(res.body)['results'];
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<MovieModel>> getFilmHighestRank() async {
    try {
      final res = await http.get(
        Uri.parse('${Url().val}movie/top_rated${Url().apiKey}'),
      );
      final List<dynamic> data = json.decode(res.body)['results'];
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
