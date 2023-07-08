import 'package:flutter/material.dart';
import 'package:movie/models/coming_soon_movie_model.dart';
import 'package:movie/models/now_play_movie_model.dart';
import 'package:movie/models/popular_movie_model.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/widgets/title_text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // 인기 영화 리스트 조회
  final Future<List<PopularMovieModel>> popularMovies =
      ApiService.getPopularMovieList();

  // 상영중 영화 리스트 조회
  final Future<List<NowPlayMovieModel>> nowPlayMovies =
      ApiService.getNowPlayMovieList();

  // 개봉할 영화 리스트 조회
  final Future<List<ComingSoonModel>> comingSoonMovies =
      ApiService.getComingSoonMovieList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              /* 인기 영화 리스트 start */
              const TitleText(
                title: '인기 영화',
                textColor: Colors.black,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return popularMovieList(snapshot);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              /* 인기 영화 리스트 end */

              /* 상영중 영화 리스트 start */
              const TitleText(
                title: '상영중인 영화',
                textColor: Colors.black,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 230,
                child: FutureBuilder(
                  future: nowPlayMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return movieList(snapshot);
                    }
                    return Container();
                  },
                ),
              ),
              /* 상영중 영화 리스트 end */

              /* 개봉할 영화 리스트 start */
              const TitleText(
                title: '개봉 할 영화',
                textColor: Colors.black,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 230,
                child: FutureBuilder(
                  future: comingSoonMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return movieList(snapshot);
                    }
                    return Container();
                  },
                ),
              ),
              /* 개봉할 영화 리스트 end */
            ],
          ),
        ),
      ),
    );
  }

  ListView movieList(AsyncSnapshot<List<dynamic>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(5, 5),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ]),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movie.thumb}',
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                snapshot.data![index].title,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 15,
      ),
    );
  }

  ListView popularMovieList(AsyncSnapshot<List<PopularMovieModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var popularMovie = snapshot.data![index];
        return Column(
          children: [
            Container(
              height: 160,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${popularMovie.thumb}',
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
                },
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 30,
      ),
    );
  }
}
