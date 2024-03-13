import 'package:Klasspadel/Page/TrainingConfiguration/Text/constant_text_training_config.dart';

import 'package:flutter/material.dart';

class TitlePageTrainig extends StatelessWidget {
  const TitlePageTrainig({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      // depth1frame0MPC (1:4)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
      padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 8 * fem),
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: const SizedBox(
        // depth2frame0drW (1:5)
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ConstantsTextTrainingConfig.trainigConfig,
            ),
          ],
        ),
      ),
    );
  }
}
