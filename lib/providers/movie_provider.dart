import 'package:flutter/material.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/models/movie_model.dart';
import 'package:tdbd_trans_berjaya_khatulistiwa/services/film/film_services.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieModel> _trendMovies = [];
  List<MovieModel> _trendMoviesbyGenre = [];
  List<MovieModel> _movieThisMonth = [];
  List<MovieModel> _movieHighestRank = [];

  List<MovieModel> get trendMovies => _trendMovies;
  List<MovieModel> get trendMoviesbyGenre => _trendMoviesbyGenre;
  List<MovieModel> get movieThisMonth => _movieThisMonth;
  List<MovieModel> get movieHighestRank => _movieHighestRank;

  Future<void> fetchMovieThisMonth() async {
    try {
      _movieThisMonth = await FilmService().getFilmThisMonth();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchMovies(String type) async {
    try {
      _trendMovies = await FilmService().getFilmTrend('week', type);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchMoviesbyGenre(String type, String id) async {
    try {
      _trendMoviesbyGenre = await FilmService().getFilmTrend('week', type);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchMovieHighestRank() async {
    try {
      _movieHighestRank = await FilmService().getFilmHighestRank();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchInitialMovies() async {
    try {
      _trendMovies = await FilmService().getFilmTrend('week', 'all');
      _movieThisMonth = await FilmService().getFilmThisMonth();
      _movieHighestRank = await FilmService().getFilmHighestRank();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
