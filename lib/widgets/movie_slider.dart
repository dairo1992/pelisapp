import 'package:flutter/material.dart';
import 'package:pelisapp/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> popularMovie;
  final String? title;
  final Function onNextpage;
  const MovieSlider(
      {Key? key,
      required this.popularMovie,
      this.title,
      required this.onNextpage})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextpage();
      }
      // print(scrollController.position.pixels);
      // print(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.title!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.popularMovie.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _MoviePoster(
                      widget.popularMovie[index],
                      '${widget.title}-${index}-${widget.popularMovie[index].id}')),
            )
          ],
        ));
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;
  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: const AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
