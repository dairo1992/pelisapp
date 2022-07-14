import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelisapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '13663d3deadda78c9b587aba2633e0d5';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> top_ratedMovies = [];
  int _popularpage = 0;
  int _top_rated = 0;

  Map<int, List<Cast>> movieCastMap = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    gettopRatedMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': page.toString(),
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final noePlayingRreponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = noePlayingRreponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularpage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularpage);
    final popularResponse = PopuparResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  gettopRatedMovies() async {
    _top_rated++;
    final jsonData = await _getJsonData('3/movie/top_rated', _top_rated);
    final topRatedResponse = PopuparResponse.fromJson(jsonData);
    top_ratedMovies = [...top_ratedMovies, ...topRatedResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getmovieCast(int id) async {
    print('pidiendo actores');
    final jsonData = await _getJsonData('3/movie/$id/credits');
    final creditsResponse = CreditsMovie.fromJson(jsonData);
    movieCastMap[id] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
