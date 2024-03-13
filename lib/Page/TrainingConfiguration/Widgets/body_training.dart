import 'package:Klasspadel/Page/TrainingConfiguration/Text/constant_text_training_config.dart';
import 'package:Klasspadel/Page/TrainingConfiguration/Widgets/card_coach.dart';
import 'package:Klasspadel/Page/TrainingConfiguration/Widgets/list_weekend.dart';
import 'package:Klasspadel/Page/TrainingConfiguration/Widgets/search_coach_containter.dart';
import 'package:Klasspadel/Page/TrainingConfiguration/Widgets/titlepage.dart';
import 'package:flutter/material.dart';

class BodyTrainig extends StatefulWidget {
  const BodyTrainig({super.key});

  @override
  State<BodyTrainig> createState() => _BodyTrainigState();
}

class _BodyTrainigState extends State<BodyTrainig> {
  bool isSelectCoach = false;
  String nameCoatch = "";
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          height: 844 * fem,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Container(
            // depth0frame0SGE (1:3)
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TitlePageTrainig(),
                SearchCoachContainer(
                  onSelectPLayer: (String value) {
                    print(value);
                    nameCoatch = value;
                    isSelectCoach = true;
                    setState(() {});
                  },
                ),
                isSelectCoach
                    ? CardCoach(
                        onDeleteCoatch: (bool value) {
                          isSelectCoach = false;
                          setState(() {});
                        },
                        name: nameCoatch,
                      )
                    : const SizedBox(
                        height: 100,
                        child: Text(ConstantsTextTrainingConfig.coatchSelected),
                      ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 76 * fem),
                  padding: EdgeInsets.fromLTRB(
                      12 * fem, 12 * fem, 16 * fem, 12 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            4 * fem, 0 * fem, 0 * fem, 24 * fem),
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffededed),
                          borderRadius: BorderRadius.circular(24 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // depth3frame0aRc (1:50)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 2 * fem, 12 * fem, 0 * fem),
                              width: 24 * fem,
                              height: 24 * fem,
                              child: Image.asset(
                                'assets/images/Vector-3.png',
                                width: 24 * fem,
                                height: 24 * fem,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 2 * fem, 12 * fem, 0 * fem),
                              width: 260,
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                onChanged: (value) {},
                                key: Key("Club"),
                                initialValue: "",
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: const InputDecoration(
                                  fillColor: Colors.transparent,
                                  // hintText: "Buscar club",
                                  labelText: "Buscar club",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0,
                                        color:
                                            Colors.transparent), //<-- SEE HERE
                                  ),
                                  filled: true,
                                ),
                                onSaved: (value) => {},
                                validator: (value) {
                                  return "Buscar club";
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        // depth2frame0pqk (1:58)
                        margin: EdgeInsets.fromLTRB(
                            4 * fem, 0 * fem, 0 * fem, 24 * fem),
                        width: double.infinity,
                        height: 40 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // depth4frame0L3Q (1:60)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 131.53 * fem, 0 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  16 * fem, 9.5 * fem, 16 * fem, 9.5 * fem),
                              width: 100,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffededed),
                                borderRadius: BorderRadius.circular(20 * fem),
                              ),
                              child: Container(
                                // depth5frame0dYJ (1:61)
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xffededed),
                                ),
                                child: const Icon(Icons.map),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Container(
                              // depth4frame0vGW (1:65)
                              padding: EdgeInsets.fromLTRB(17.85 * fem,
                                  9.5 * fem, 17.85 * fem, 9.5 * fem),
                              width: 84 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffea2830),
                                borderRadius: BorderRadius.circular(20 * fem),
                              ),
                              child: Container(
                                // depth5frame0quG (1:66)
                                width: double.infinity,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xffea2830),
                                ),
                                child: const Text(
                                  'Buscar',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListWeekDay(),
                      ),
                      Container(
                        // depth2frame0Dw4 (1:116)
                        margin: EdgeInsets.fromLTRB(
                            4 * fem, 0 * fem, 0 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            146.28 * fem, 12 * fem, 145.72 * fem, 12 * fem),
                        width: 358 * fem,
                        height: 48 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xffea2830),
                          borderRadius: BorderRadius.circular(24 * fem),
                        ),
                        child: InkWell(
                          onTap: () {
                            print("object");
                          },
                          child: Container(
                            // depth3frame0Xwk (1:117)
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xffea2830),
                            ),
                            child: Center(
                              child: Text(
                                'Guardar',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // depth1frame9pvr (1:121)
                  width: double.infinity,
                  height: 20 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
