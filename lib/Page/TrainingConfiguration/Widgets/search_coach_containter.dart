import 'package:Klasspadel/Page/TrainingConfiguration/Text/constant_text_training_config.dart';
import 'package:Klasspadel/Page/test_pages.dart';
import 'package:Klasspadel/WidgetsCustom/filter_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchCoachContainer extends StatefulWidget {
  const SearchCoachContainer({super.key, required this.onSelectPLayer});
  final ValueChanged<String> onSelectPLayer;
  @override
  State<SearchCoachContainer> createState() => _SearchCoachContainerState();
}

class _SearchCoachContainerState extends State<SearchCoachContainer> {
  String _handPreference = '';
  bool selectUser = false;
  void selectPlayer(contact) {
    _handPreference = contact;
    selectUser = true;
    widget.onSelectPLayer(_handPreference);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return GestureDetector(
      onTap: () async {
        var player = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilterContactListScreen(
              oncontactSelected: selectPlayer,
            ),
          ),
        );
        if (player != null) {
          _handPreference = player;
        }
      },
      child: Container(
        height: 50,
        // depth2frame0pCE (1:19)
        margin: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 16 * fem, 12 * fem),
        padding: EdgeInsets.fromLTRB(16, 0, 10, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffededed),
          borderRadius: BorderRadius.circular(24 * fem),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                'assets/images/Vector-3.png',
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 5),
            const Text(ConstantsTextTrainingConfig.selectCoatch),
          ],
        ),
      ),
    );
  }
}
