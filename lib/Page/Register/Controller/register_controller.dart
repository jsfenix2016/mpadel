import 'package:Klasspadel/Page/Home/Pageview/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Klasspadel/Models/register_model.dart';
import 'package:Klasspadel/Page/Login/Pageview/login_screen.dart';
import 'package:Klasspadel/Page/Register/Service/register_service.dart';

// final _prefs = PreferenceUser();

class RegisterController extends GetxController {
  late BuildContext contextTemp;
  final RegisterService registerService = Get.put(RegisterService());
  RxBool isloading = false.obs;

  Future<bool> saveRegisterUser(
      BuildContext context, UserRegisterModel userModel) async {
    contextTemp = context;
    // _prefs.setAceptedSendLocation = senLocation;
    Map<String, dynamic> req = await registerService.insertRegister(userModel);
    // mostrarAlerta(context, "Se guardo correctamente");
    if (req['ok'] != null) {
      isloading = false.obs;
      var typeUser = userModel.typeUser;

      await Get.offAll(HomePage(
        typeUser: typeUser,
      ));

      return true;
    } else {
      isloading = false.obs;

      return false;
    }
  }

  Future<void> goToLogin() async {
    Navigator.push(
      contextTemp,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
