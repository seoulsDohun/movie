import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/detail_movie_model.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/widgets/rating_starts_widget.dart';
import 'package:movie/widgets/title_text_widget.dart';

class DetailScreen extends StatefulWidget {
  final String id, thumb, heroTag;
  const DetailScreen({
    Key? key,
    required this.id,
    required this.thumb,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<DetailMovieModel> detailMovie;
  bool _isButtonVisible = true;

  @override
  void initState() {
    super.initState();
    detailMovie = ApiService.getDetailMovie(widget.id);
  }

  String minFormat(int minutes) {
    var duration = Duration(minutes: minutes);
    var returnHours = duration.toString().split('.')[0].substring(0, 1);
    var returnMinutes = duration.toString().split('.')[0].substring(2, 4);
    return '${returnHours}h ${returnMinutes}min';
  }

  String genreFormat(List<dynamic> genres) {
    var returnGenres = "";
    var index = 0;
    for (var genre in genres) {
      if (index != 0) {
        returnGenres += ', ${genre['name']}';
      } else {
        returnGenres += genre['name'];
      }
      index++;
    }
    return returnGenres;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.heroTag,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500/${widget.thumb}',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          if (ModalRoute.of(context)?.canPop ?? false)
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isButtonVisible = false;
                        });
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                    ),
                    const Text(
                      'Back to list',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          FutureBuilder(
            future: detailMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var movieData = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 300),
                          TitleText(
                            title: movieData.title,
                            textColor: Colors.white,
                          ),
                          RatingStars(rating: movieData.voteAverage.toDouble()),
                          const SizedBox(height: 10),
                          Text(
                            '${minFormat(movieData.runtime.toInt())} | ${genreFormat(movieData.genres)}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Storyline',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            movieData.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedOpacity(
                                opacity: _isButtonVisible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 100),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 100,
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: Colors.amber,
                                  ),
                                  child: const Text('Buy ticket'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
