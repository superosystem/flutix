part of '../pages.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // SECT: HEADER
        Container(
          decoration: BoxDecoration(
              color: primaryAccentColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          padding: const EdgeInsets.fromLTRB(
            defaultMargin,
            20,
            defaultMargin,
            30,
          ),
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              if (imageFileToUpload != null) {
                uploadImage(imageFileToUpload!).then((downloadURL) {
                  imageFileToUpload = null;
                  context
                      .read<UserBloc>()
                      .add(UpdateData(profileImage: downloadURL, name: ''));
                });
              }

              // SECT:  PROFILE CARD
              return Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF5F558B), width: 1)),
                      child: Stack(
                        children: <Widget>[
                          SpinKitFadingCircle(
                              color: secondaryAccentColor, size: 50),
                          Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (userState.user.profilePicture ==
                                              ""
                                          ? const AssetImage(
                                              "assets/user_pic.png")
                                          : NetworkImage(
                                                  userState.user.profilePicture)
                                              as ImageProvider),
                                      fit: BoxFit.cover))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            78,
                        child: Text(
                          userState.user.name,
                          style: whiteTextFont.copyWith(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "IDR ")
                                  .format(userState.user.balance),
                              style: yellowNumberFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400))),
                    ],
                  )
                ],
              );
            } else {
              return SpinKitFadingCircle(
                color: secondaryAccentColor,
                size: 50,
              );
            }
          }),
        ),

        // SECT: NOW PLAYING
        Container(
            margin:
                const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text('Now Playing',
                style: blackTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold))),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, state) {
              if (state is MovieLoaded) {
                List<Movie> movies = state.movies.sublist(0, 10);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                        left: (index == 0) ? defaultMargin : 0,
                        right:
                            (index == movies.length - 1) ? defaultMargin : 16),
                    child: MovieCard(
                      movies[index],
                      onTap: () {
                        context
                            .read<PageBloc>()
                            .add(GoToMovieDetailPage(movies[index]));
                      },
                    ),
                  ),
                );
              } else {
                return SpinKitFadingCircle(color: primaryAccentColor, size: 50);
              }
            },
          ),
        ),

        // SECT: BROWSE CATEGORY MOVIE
        Container(
          margin:
          const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Browse Movie",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      userState.user.selectedGenres.length,
                          (index) =>
                          BrowseButton(userState.user.selectedGenres[index])),
                ),
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            }
          },
        ),

        //SECT: COMMING SOON
        Container(
          margin:
          const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Cooming Soon",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(10);

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: (index == movies.length - 1)
                              ? defaultMargin
                              : 16),
                      child: ComingSoonCard(movies[index]),
                    ));
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        ),
        Container(
          margin:
          const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Get Lucky Day",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // SECT: PROMO
        Column(
          children: dummyPromos
              .map((e) => Padding(
              padding: const EdgeInsets.fromLTRB(
                  defaultMargin, 0, defaultMargin, 16),
              child: PromoCard(e)))
              .toList(),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
