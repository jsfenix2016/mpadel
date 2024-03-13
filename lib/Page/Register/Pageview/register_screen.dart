import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Common/constants_text.dart';

import 'package:Klasspadel/Page/Loading/loading_screen.dart';
import 'package:Klasspadel/Page/Register/Widgets/container_custom_register_data.dart';

import 'package:Klasspadel/WidgetsCustom/logo_custom.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Klasspadel/Models/register_model.dart';
import 'package:Klasspadel/Models/rol_model.dart';
import 'package:Klasspadel/Page/Register/Controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerVC = Get.put(RegisterController());

  late RolModel rolModel;

  List<RolModel> listTypeUser = [];
  bool alumno = false;
  bool choach = false;
  bool fisical = false;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
  }

  List<RolModel> selectTypeUser() {
    if (alumno) {
      listTypeUser.add(RolModel(idRol: 0));
    }
    if (choach) {
      listTypeUser.add(RolModel(idRol: 1));
    }
    if (fisical) {
      listTypeUser.add(RolModel(idRol: 2));
    }

    return listTypeUser;
  }

  void stopLoading() {
    setState(() {
      isloading = false;
    });
  }

  void goToHome(UserRegisterModel userRegisterModel) async {
    setState(() {
      isloading = true;
    });
    if (userRegisterModel.email.isEmpty) {
      stopLoading();
      showSaveAlert(context, 'info_title_alerts'.tr, "email_empty".tr);
      return;
    }

    if (userRegisterModel.pass.isEmpty) {
      stopLoading();
      showSaveAlert(context, 'info_title_alerts'.tr, "password_empty".tr);
      return;
    }
    if (!userRegisterModel.terms) {
      stopLoading();
      return;
    }
    if (userRegisterModel.pass.isNotEmpty &&
        userRegisterModel.email.isNotEmpty &&
        userRegisterModel.terms) {
      if (!validateEmail(userRegisterModel.email)) {
        showSaveAlert(context, ConstantsText.info, ConstantsText.validateEmail);
        stopLoading();
        return;
      }

      bool continuePage =
          await registerVC.saveRegisterUser(context, userRegisterModel);

      if (continuePage) {
        stopLoading();
        registerVC.goToLogin();
      } else {
        stopLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      isLoading: isloading,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 50),
                const SizedBox(height: 100, width: 310, child: LogoCustomApp()),
                ContainerCustomRegisterData(
                  onRegister: goToHome,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
