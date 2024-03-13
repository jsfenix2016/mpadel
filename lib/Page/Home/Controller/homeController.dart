import 'package:Klasspadel/Common/hive_data.dart';
import 'package:Klasspadel/Models/player_model.dart';
import 'package:Klasspadel/ModelsBD/videobd.dart';

import 'package:Klasspadel/Page/Home/Service/home_service.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeService homeService = Get.put(HomeService());

  Future<List<PlayerModel>> getAllPlayer() async {
    return await homeService.getAllPlayer();
  }

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
