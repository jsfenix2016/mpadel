import 'package:flutter/material.dart';

class CardCoach extends StatefulWidget {
  const CardCoach(
      {super.key, required this.onDeleteCoatch, required this.name});
  final ValueChanged<bool> onDeleteCoatch;
  final String name;
  @override
  State<CardCoach> createState() => _CardCoachState();
}

class _CardCoachState extends State<CardCoach> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      // depth2frame063G (1:28)
      padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
      width: double.infinity,
      height: 167 * fem,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Container(
        // depth3frame0Qpe (1:29)
        padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12 * fem),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              offset: Offset(0 * fem, 0 * fem),
              blurRadius: 2 * fem,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // depth4frame0G6A (1:30)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 40.67 * fem, 0 * fem),
              width: 182 * fem,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // depth5frame0Zqx (1:31)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // nombredelentrenadorJYe (1:34)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 4 * fem),
                          child: Text(
                            widget.name,
                          ),
                        ),
                        Text(
                          // nivelexpertoD9p (1:37)
                          'Nivel: Experto',
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onDeleteCoatch(true);
                    },
                    child: Container(
                      // depth5frame1MG2 (1:38)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 83.64 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 5.5 * fem, 8 * fem, 5.5 * fem),
                      width: 100,
                      height: 32 * fem,
                      decoration: BoxDecoration(
                        color: Color(0xffededed),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // depth6frame0SYN (1:39)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 4 * fem, 0 * fem),
                            width: 70.36 * fem,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffededed),
                            ),
                            child: Text(
                              'Eliminar',
                            ),
                          ),
                          // Container(
                          //   // depth6frame17uQ (1:42)
                          //   width: 30,
                          //   height: 30,
                          //   child: Icon(
                          //     Icons.delete,
                          //     size: 18,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // depth5frame0r6J (1:47)
              width: 103.33 * fem,
              height: 93 * fem,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12 * fem),
                child: Image.asset(
                  'assets/images/onboarding2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
