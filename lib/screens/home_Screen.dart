// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pelisapp/providers/movies_provider.dart';
import 'package:pelisapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('peliculas en cine'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SwiperScreen(movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                  popularMovie: moviesProvider.popularMovies,
                  title: 'Populares',
                  onNextpage: () => moviesProvider.getPopularMovies()),
              MovieSlider(
                popularMovie: moviesProvider.top_ratedMovies,
                title: 'Mas valoradas',
                onNextpage: () => moviesProvider.gettopRatedMovies(),
              )
            ],
          ),
        ));
  }
}
