import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:Klasspadel/Common/gradient_customs.dart';
import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:Klasspadel/Common/text_style_custom.dart';
import 'package:Klasspadel/Page/Loading/loading_screen.dart';
import 'package:Klasspadel/WidgetsCustom/logo_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Klasspadel/Page/Login/Controller/loginController.dart';
import 'package:Klasspadel/Page/Register/Pageview/register_screen.dart';
import 'package:Klasspadel/WidgetsCustom/textfieldCustom.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginVC = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _urlApiController = TextEditingController();
  final PreferenceUser pref = PreferenceUser();
  @override
  void initState() {
    super.initState();
    getDeviceType();
  }

  void getDeviceType() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    if (allInfo.keys.contains('iPhone')) {
    } else if (allInfo.keys.contains('iPad')) {
    } else {}
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showDialogChangePass() {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "request_password".tr,
              style: styleCustomGoodTimesBold(),
            ),
            content: Form(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "email".tr,
                  labelStyle: styleCustomGoodTimesBold(),
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  print("object");
                },
                child: SizedBox(
                  height: 42,
                  width: 200,
                  child: Center(
                    child: Text(
                      'send'.tr,
                      style: styleCustomGoodTimesBold(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  height: 42,
                  width: 200,
                  child: Center(
                    child: Text(
                      'cancel'.tr,
                      style: styleCustomGoodTimesBold(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  void goToRegister() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
      );
    });
  }

  void showDialogError() {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'info_title_alerts'.tr,
              style: styleCustomGoodTimesBold(),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  height: 42,
                  width: 200,
                  child: Center(
                    child: Text(
                      'ok',
                      style: styleCustomGoodTimesBold(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (c) {
          return LoadingIndicator(
            isLoading: c.isloading.value,
            child: Container(
              decoration: decorationCustomWhite(),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const SizedBox(
                        height: 100, width: 310, child: LogoCustomApp()),
                    Center(
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
                              'titulo_login'.tr,
                              style: styleGoodTimes24BlackBold(),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFieldFormCustomBorder(
                                labelText: "aqui debes colocar la url",
                                mesaje: "",
                                onChanged: (String value) {
                                  pref.setUrlTemp = value;
                                },
                                placeholder: "",
                                typeInput: TextInputType.text,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              child: Text(
                                'change_password'.tr,
                                style: styleGoodTimes14WhiteBold(),
                              ),
                              onPressed: () {
                                showDialogChangePass();
                              },
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: SizedBox(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loginVC.isloading = true.obs;
                                    });
                                    bool req = await loginVC.goToHome(
                                        _emailController.text,
                                        _passwordController.text);

                                    if (req == false) {
                                      showDialogError();
                                    }
                                  },
                                  child: SizedBox(
                                    height: 42,
                                    child: Center(
                                      child: Text(
                                        'access'.tr,
                                        style: styleCustomGoodTimesBold(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    goToRegister();
                                  },
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
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
