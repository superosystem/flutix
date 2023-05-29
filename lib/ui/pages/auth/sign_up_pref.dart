part of '../pages.dart';

class SignUpPreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];

  final List<String> languages = [
    "English",
    "Indonesian",
    "Japanese",
    "Korean",
  ];
  final SignUpModel signUpData;

  SignUpPreferencePage(this.signUpData, {Key? key}) : super(key: key);

  @override
  _SignUpPreferencePageState createState() => _SignUpPreferencePageState();
}

class _SignUpPreferencePageState extends State<SignUpPreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.signUpData.password = "";

        context.read<PageBloc>().add(GoToSignUpPage(widget.signUpData));

        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 56,
                    margin: const EdgeInsets.only(top: 20, bottom: 4),
                    child: GestureDetector(
                        onTap: () {
                          widget.signUpData.password = "";

                          context
                              .read<PageBloc>()
                              .add(GoToSignUpPage(widget.signUpData));
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  Text(
                    "Select Your Four\nFavorite Genres",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateGenreWidgets(context),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Movie Language\nYou Prefer",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLangWidgets(context),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: mainColor,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (selectedGenres.length != 4) {
                          Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: const Color(0xFFFF5C83),
                            message: "Please select 4 genres",
                          ).show(context);
                        } else {
                          widget.signUpData.selectedGenres = selectedGenres;
                          widget.signUpData.selectedLanguage = selectedLanguage;

                          context.read<PageBloc>().add(
                              GoToSignUpAccountConfirmationPage(
                                  widget.signUpData));
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    List<Widget> genre = widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();

    return genre;
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    List<Widget> language = widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();

    return language;
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
