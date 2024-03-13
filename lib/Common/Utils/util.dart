import 'package:Klasspadel/Common/text_style_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {}

MaterialColor colorController(int position) {
  switch (position) {
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    case 3:
      return Colors.yellow;
    case 4:
      return Colors.blue;
    default: // Without this, you see a WARNING.
  }
  return Colors.brown;
}

bool validateEmail(String email) {
  // Expresión regular para validar el correo electrónico
  final RegExp regex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([a-z0-9]+(\.[a-z0-9]+)*\.)+[a-z]{2,}$');
  return regex.hasMatch(email);
}

Future<Uint8List> loadImage(String path) async {
  final byteData = await rootBundle.load(path);
  return byteData.buffer.asUint8List();
}

double porcentaje(int valor, double size) {
  double res = (valor / size) * 100;
  return res;
}

void showSaveAlert(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK", style: styleCustomGoodTimesBold()),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
