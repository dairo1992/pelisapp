import 'package:flutter/material.dart';
import 'package:pelisapp/models/models.dart';
import 'package:pelisapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return const Center(
      child:
          Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 150),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return _emptyContainer();
    }

    return FutureBuilder(
      future: moviesProvider.getSearchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }
        final movie = snapshot.data;
        return ListView.builder(
            itemCount: movie!.length,
            itemBuilder: (_, int index) {
              return _Movieitem(movie[index]);
            });
      },
    );
  }
}

class _Movieitem extends StatelessWidget {
  final movie;
  const _Movieitem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      leading: FadeInImage(
          placeholder: const AssetImage('assets/img/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 80,
          fit: BoxFit.contain),
      onTap: () => {Navigator.pushNamed(context, 'details', arguments: movie)},
    );
  }
}
