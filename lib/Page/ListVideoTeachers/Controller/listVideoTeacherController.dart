import 'package:Klasspadel/Common/hive_data.dart';
import 'package:Klasspadel/ModelsBD/videobd.dart';

import 'package:get/get.dart';

class ListVideoTeacherController extends GetxController {
  Future<List<VideoBD>> getAllMyVideos() async {
    final allVideo = await const HiveData().getAllMyVideo();

    // mostrarAlerta(context, "Se guardo correctamente");
    if (allVideo.isNotEmpty) {
      return allVideo;
    } else {
      return [];
    }
  }
}
