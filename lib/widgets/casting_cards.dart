import 'package:flutter/cupertino.dart';
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
          if (!snapshot.hasData) {
            return Container(
                constraints: const BoxConstraints(maxWidth: 150),
                margin: const EdgeInsets.only(bottom: 30),
                width: double.infinity,
                height: 180,
                child: const CupertinoActivityIndicator());
          }
          final cast = snapshot.data;
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  if (cast!.isEmpty) {
                    return Text('');
                  }
                  return _CastCard(actor: cast![index]);
                }),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({Key? key, required this.actor}) : super(key: key);

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
                child: FadeInImage(
                    placeholder: const AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(
                        actor.fullprofilePathImg ?? 'assets/img/no-image.jpg'),
                    height: 140,
                    width: 100,
                    fit: BoxFit.cover)),
            const SizedBox(
              height: 5,
            ),
            if (actor.name != null)
              Text(actor.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center)
          ],
        ));
  }
}
