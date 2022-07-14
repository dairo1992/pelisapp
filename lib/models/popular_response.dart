// To parse this JSON data, do
//
//     final popuparResponse = popuparResponseFromMap(jsonString);

import 'dart:convert';

import 'package:pelisapp/models/models.dart';

class PopuparResponse {
  PopuparResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory PopuparResponse.fromJson(String str) =>
      PopuparResponse.fromMap(json.decode(str));

  factory PopuparResponse.fromMap(Map<String, dynamic> json) => PopuparResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
