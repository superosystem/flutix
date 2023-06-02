part of '../pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  const SelectSchedulePage(this.movieDetail, {Key? key}) : super(key: key);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  late List<DateTime> dates;
  late DateTime selectedDate;
  late int selectedTime;
  Theater? selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));

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
                Row(
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: const EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<PageBloc>()
                              .add(GoToMovieDetailPage(widget.movieDetail));
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(
                      defaultMargin, 20, defaultMargin, 16),
                  child: Text(
                    "Choose Data",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  height: 90,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (_, index) => Container(
                            margin: EdgeInsets.only(
                                left: (index == 0) ? defaultMargin : 0,
                                right: (index < dates.length - 1)
                                    ? 16
                                    : defaultMargin),
                            child: DateCard(
                              dates[index],
                              isSelected: selectedDate == dates[index],
                              onTap: () {
                                setState(() {
                                  selectedDate = dates[index];
                                });
                              },
                            ),
                          )),
                ),
                generateTimeTable(),
                const SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => FloatingActionButton(
                          elevation: 0,
                          backgroundColor:
                              (isValid) ? mainColor : const Color(0xFFE4E4E4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: isValid
                                ? Colors.white
                                : const Color(0xFFBEBEBE),
                          ),
                          onPressed: () {
                            if (isValid) {
                              context.read<PageBloc>().add(GoToSelectSeatPage(
                                  Ticket(
                                      widget.movieDetail,
                                      selectedTheater!,
                                      DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime),
                                      randomAlphaNumeric(12).toUpperCase(),
                                      const [],
                                      (userState as UserLoaded).user.name,
                                      0)));
                            }
                          }),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(6, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      widgets.add(Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child:
              Text(theater.name, style: blackTextFont.copyWith(fontSize: 20))));

      widgets.add(Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
                left: (index == 0) ? defaultMargin : 0,
                right: (index < schedule.length - 1) ? 16 : defaultMargin),
            child: SelectableBox(
              "${schedule[index]}:00",
              height: 50,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate.day != DateTime.now().day,
              onTap: () {
                setState(() {
                  selectedTheater = theater;
                  selectedTime = schedule[index];
                  isValid = true;
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
