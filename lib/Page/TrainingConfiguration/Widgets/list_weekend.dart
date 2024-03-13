import 'package:Klasspadel/Common/colors_palette.dart';
import 'package:flutter/material.dart';

class ListWeekDay extends StatefulWidget {
  const ListWeekDay({super.key});

  @override
  State<ListWeekDay> createState() => _ListWeekDayState();
}

class _ListWeekDayState extends State<ListWeekDay> {
  late String timeLblAM = "00:00"; //AM
  late String timeLblPM = "00:00"; //PM
  var indexSelect = -1;

  var isSelect = false;
  int noSelectDay = 1;
  // late RestDay restDay;
  // final List<RestDayBD> tempDicRest = [];
  final List<int> tempList = <int>[];
  final List<int> tempListConfig = <int>[];
  final List<String> _ListDay = <String>[
    "L",
    "M",
    "X",
    "J",
    "V",
    "S",
    "D",
  ];
  final List<String> tempNoSelectListDay = <String>[
    "L",
    "M",
    "X",
    "J",
    "V",
    "S",
    "D",
  ];

  final List<String> _selectedDays = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            color: Colors.transparent,
            child: Column(
              key: Key(index.toString()),
              children: [
                Row(
                  key: Key(index.toString()),
                  children: [
                    for (var i = 0; i < tempNoSelectListDay.length; i++)
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        key: Key("$index,$i"),
                        onTap: () {
                          indexSelect = i;
                          setState(
                            () {
                              if (_selectedDays
                                  .contains(tempNoSelectListDay[i])) {
                                _selectedDays.remove(tempNoSelectListDay[i]);
                                // tempDicRest.remove(tempNoSelectListDay[i]);
                                tempNoSelectListDay.add(_ListDay[i]);
                              } else {
                                _selectedDays.add(_ListDay[i]);

                                // RestDayBD restDay = RestDayBD(
                                //     day: _ListDay[i],
                                //     timeSleep: timeLblAM,
                                //     timeWakeup: timeLblPM,
                                //     selection: i,
                                //     isSelect: true);
                                // tempDicRest.add(restDay);
                              }
                            },
                          );
                        },
                        child: Container(
                          width: size.width / 8,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Text(
                                _ListDay[i],
                                textAlign: TextAlign.center,
                                // style: GoogleFonts.barlow(
                                //   fontSize: 20.0,
                                //   wordSpacing: 1,
                                //   letterSpacing: 1,
                                //   fontWeight: FontWeight.normal,
                                //   color: _selectedDays.contains(_ListDay[i])
                                //       ? ColorPalette.principal
                                //       : Colors.white,
                                // ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Container(
                                color: _selectedDays.contains(_ListDay[i])
                                    ? ColorPalette.principal
                                    : Colors.white,
                                height:
                                    _selectedDays.contains(_ListDay[i]) ? 3 : 1,
                                width: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Positioned(
                  top: (250),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          displayTimePicker(context);
                        },
                        child: Container(
                          key: Key(index.toString()),
                          width: size.width / 2,
                          height: 70,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              // SizedBox(
                              //   child: Image.asset(
                              //     scale: 1,
                              //     fit: BoxFit.fill,
                              //     'assets/images/Group 979.png',
                              //     height: 24,
                              //     width: 44,
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  timeLblAM,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print(indexSelect);
                          displayTimePickerPM(context);
                        },
                        child: Container(
                          width: size.width / 2.5,
                          height: 83,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              // SizedBox(
                              //   child: Image.asset(
                              //     scale: 1,
                              //     fit: BoxFit.fill,
                              //     'assets/images/Ellipse 185.png',
                              //     height: 30,
                              //     width: 29,
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  timeLblPM,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future displayTimePickerPM(BuildContext context) async {
    var time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });
    if (time != null) {
      if (time.hour <= 11) {
        TimeOfDay timeOfDay = const TimeOfDay(hour: 12, minute: 00);
        // ignore: use_build_context_synchronously
        timeLblPM = timeOfDay.format(context);
      } else {
        // ignore: use_build_context_synchronously
        timeLblPM = time.format(context);
      }

      // for (var element in _selectedDays) {}

      // for (var element in tempDicRest) {}
    }
    setState(() {});
  }

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });
    if (time != null) {
      if (time.hour > 11) {
        TimeOfDay timeOfDay = const TimeOfDay(hour: 13, minute: 0);
        timeLblAM = timeOfDay.format(context);
        // timeLblAM = _timeC.text;
      } else {
        timeLblAM = time.format(context);
        // timeLblAM = _timeC.text;
      }

      setState(() {});
    }
  }
}
