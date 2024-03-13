import 'package:Klasspadel/Common/hive_data.dart';
import 'package:Klasspadel/ModelsBD/videobd.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EditController extends GetxController {
  Future<bool> saveVideo(VideoBD video) async {
    final save = await const HiveData().saveVideo(video);

    // mostrarAlerta(context, "Se guardo correctamente");
    if (save) {
      return true;
    } else {
      return false;
    }
  }
}
