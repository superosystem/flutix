part of '../pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late MovieDetail movieDetail;
    late List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(const GoToMainPage());

        return Future.value(true);
      },
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            color: accentColor1,
          ),
          SafeArea(
              child: Container(
            color: Colors.white,
          )),
          ListView(
            children: <Widget>[
              FutureBuilder(
                  future: MovieServices.getDetails(movie),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      movieDetail = snapshot.data as MovieDetail;
                    }

                    return Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            // note: BACKDROP
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 270,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${imageBaseURL}w1280${movie.backdropPath}"),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  height: 271,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: const Alignment(0, 1),
                                          end: const Alignment(0, 0.06),
                                          colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0)
                                      ])),
                                )
                              ],
                            ),
                            // note: BACK ICON
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 20, left: defaultMargin),
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black.withOpacity(0.04)),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<PageBloc>()
                                      .add(const GoToMainPage());
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        // note: JUDUL
                        Container(
                          margin: const EdgeInsets.fromLTRB(
                              defaultMargin, 16, defaultMargin, 6),
                          child: Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(fontSize: 24),
                          ),
                        ),
                        // note: GENRE
                        (snapshot.hasData)
                            ? Text(
                                movieDetail.genresAndLanguage,
                                style: greyTextFont.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              )
                            : SizedBox(
                                height: 50,
                                width: 50,
                                child: SpinKitFadingCircle(
                                  color: accentColor3,
                                ),
                              ),
                        const SizedBox(
                          height: 6,
                        ),
                        // note: RATING
                        RatingStars(
                          voteAverage: movie.voteAverage,
                          color: accentColor3,
                          alignment: MainAxisAlignment.center,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // note: CREDITS
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: defaultMargin, bottom: 12),
                              child: Text(
                                "Cast & Crew",
                                style: blackTextFont.copyWith(fontSize: 14),
                              )),
                        ),
                        FutureBuilder(
                            future: MovieServices.getCredits(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                credits = snapshot.data as List<Credit>;
                                return SizedBox(
                                  height: 115,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: credits.length,
                                      itemBuilder: (_, index) => Container(
                                          margin: EdgeInsets.only(
                                              left: (index == 0)
                                                  ? defaultMargin
                                                  : 0,
                                              right:
                                                  (index == credits.length - 1)
                                                      ? defaultMargin
                                                      : 16),
                                          child: CreditCard(credits[index]))),
                                );
                              } else {
                                return SizedBox(
                                    height: 50,
                                    child: SpinKitFadingCircle(
                                      color: accentColor1,
                                    ));
                              }
                            }),
                        // note: STORYLINE
                        Container(
                          margin: const EdgeInsets.fromLTRB(
                              defaultMargin, 24, defaultMargin, 8),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Storyline",
                              style: blackTextFont,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(
                              defaultMargin, 0, defaultMargin, 30),
                          child: Text(
                            movie.overview,
                            style: greyTextFont.copyWith(
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            "Continue to Book",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                          onPressed: () {
                            context
                                .read<PageBloc>()
                                .add(GoToSelectSchedulePage(movieDetail));
                          },
                        ),
                        const SizedBox(height: defaultMargin),
                      ],
                    );
                  }),
            ],
          ),
        ],
      )),
    );
  }
}
