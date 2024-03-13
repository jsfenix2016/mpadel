import 'package:Klasspadel/Common/gradient_customs.dart';
import 'package:Klasspadel/Common/text_style_custom.dart';
import 'package:Klasspadel/Models/register_model.dart';
import 'package:Klasspadel/Models/rol_model.dart';
import 'package:Klasspadel/WidgetsCustom/checkbox_custom.dart';
import 'package:Klasspadel/WidgetsCustom/textfieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerCustomRegisterData extends StatefulWidget {
  const ContainerCustomRegisterData({super.key, required this.onRegister});

  final ValueChanged<UserRegisterModel> onRegister;
  @override
  State<ContainerCustomRegisterData> createState() =>
      _ContainerCustomRegisterDataState();
}

class _ContainerCustomRegisterDataState
    extends State<ContainerCustomRegisterData> {
  late UserRegisterModel userRegisterModel =
      UserRegisterModel(email: "", pass: "", terms: false, typeUser: "");
  late RolModel rolModel;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String typeUser = "Player";
  bool terms = false;

  void goToRegister() {
    widget.onRegister(userRegisterModel);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          gradient: gradientTreeColors(),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Registro'.tr,
              style: styleGoodTimes24BlackBold(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFieldFormCustomBorder(
                labelText: "email".tr,
                mesaje: "",
                onChanged: (String value) {
                  _emailController.text = value;
                },
                placeholder: "",
                typeInput: TextInputType.text,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFieldFormCustomBorder(
                labelText: "password".tr,
                mesaje: "",
                onChanged: (String value) {
                  _passwordController.text = value;
                },
                placeholder: "",
                typeInput: TextInputType.text,
              ),
            ),
            const SizedBox(height: 10),
            RadioListTile(
              title: Text(
                "Player",
                style: styleGoodTimes14WhiteBold(),
              ),
              activeColor: Colors.white,
              value: "Player",
              groupValue: typeUser,
              onChanged: (value) {
                setState(() {
                  typeUser = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text(
                "Coach",
                style: styleGoodTimes14WhiteBold(),
              ),
              activeColor: Colors.white,
              value: "Coach",
              groupValue: typeUser,
              onChanged: (value) {
                setState(() {
                  typeUser = value.toString();
                });
              },
            ),
            CheckBoxCustom(
              valueType: terms,
              title: "Terminos y condiciones",
              onChanged: (value) {
                terms = value;

                setState(() {
                  userRegisterModel.terms = value;
                });
              },
              styleCustom: styleGoodTimes14WhiteBold(),
              unselectedColorCustom: Colors.white,
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () => goToRegister(),
                  child: SizedBox(
                    height: 42,
                    child: Center(
                      child: Text(
                        'register'.tr,
                        style: styleCustomGoodTimesBold(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
