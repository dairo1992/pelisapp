import 'package:flutter/material.dart';
import 'package:pelisapp/models/models.dart';
import 'package:pelisapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {
  final int movieId;
  const CastingCard({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
        future: moviesProvider.getmovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => _CastCard()),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage('https://via.placeholder.com/150x300'),
                    height: 140,
                    width: 100,
                    fit: BoxFit.cover)),
            const SizedBox(
              height: 5,
            ),
            const Text('actor.name',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center)
          ],
        ));
  }
}
