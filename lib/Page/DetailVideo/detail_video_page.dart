import 'dart:io';
import 'dart:typed_data';

import 'package:Klasspadel/Models/thumbnail.dart';
import 'package:Klasspadel/ModelsBD/thumbnailbd.dart';
import 'package:Klasspadel/ModelsBD/videobd.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/container_list_recoder.dart';

import 'package:Klasspadel/WidgetsCustom/barPlayer.dart';
import 'package:Klasspadel/WidgetsCustom/loading_custom.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsScreen extends StatefulWidget {
  final VideoBD video;

  const VideoDetailsScreen({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  late Stream<double> videoPositionStream;
  bool isloading = false;

  List<Widget> thumbnailsTemp = [];
  late List<Thumbnail> listThumbnail = [];
  Thumbnail? thumb;
  late VideoBD itemTemp;
  double aspectRatio = 9 / 16;
  bool isVisibily = true;
  int selectIndexThum = -1;
  String elapsedTimeString = '';
  @override
  void initState() {
    Thumbnail thumbnailTemp = Thumbnail(
        timeMs: 0.toString(),
        imageUrl: Uint8List(0),
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now().toIso8601String(),
        pathRecoded: '',
        timeDurationRecoded: '',
        titleRecoded: '');
    itemTemp = widget.video;
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.urlVideo));

    initializeVideoPlayerFuture = _videoPlayerController.initialize();
    videoPositionStream =
        Stream<double>.periodic(const Duration(milliseconds: 200), (_) {
      return _videoPlayerController.value.position.inMilliseconds.toDouble();
    }).takeWhile((position) {
      return _videoPlayerController.value.isPlaying &&
          position <=
              _videoPlayerController.value.duration.inMilliseconds.toDouble();
    });

    _videoPlayerController.pause();

    for (var element in widget.video.listThumbnail) {
      Thumbnail thum = Thumbnail(
        timeMs: element.timeMs.toString(),
        imageUrl: element.imageUrl,
        titleThumb: element.titleThumb,
        descriptionThumb: element.descriptionThumb,
        timeCapture: element.timeCapture.toIso8601String(),
        timeDurationRecoded: element.timeDurationRecoded,
        titleRecoded: element.titleRecoded,
        pathRecoded: element.recoderPath ?? '',
      );
      listThumbnail.add(thum);
    }

    // generateThumbnails(File(widget.item.urlVideo).path);
    super.initState();
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Video'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: initializeVideoPlayerFuture,
              builder: (context, state) {
                if (state.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingCustom());
                } else {
                  if (_videoPlayerController.value.isInitialized) {
                    Duration elapsedTimeTemp = Duration(
                        seconds:
                            _videoPlayerController.value.duration.inSeconds);
                    // var a = format.format(Duration(seconds: _elapsedTime));
                    elapsedTimeString =
                        "${elapsedTimeTemp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(elapsedTimeTemp.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
                  }
                  return Stack(children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        color: Colors.transparent,
                        width: size.width,
                        child: BarPlayer(
                          videoPlayerController: _videoPlayerController,
                          videoPositionStream: videoPositionStream,
                          thumbnails: const [],
                          onChangedThum: (ThumbnailBD value) {
                            // widget.onChangedThum(value);
                          },
                          onChangedTimeThumbnail: (int value) {
                            // widget.onChangedTimeThumbnail(value);
                          },
                        ),
                      ),
                    ),
                  ]);
                }
              },
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 300,
                width: size.width,
                color: Colors.amber,
                child: ContainerListRecoder(
                  listThumbnail: listThumbnail,
                  left: 0.0,
                  onClose: (bool value) {},
                  onDelete: (int value) {},
                  onShowThumb: (int value) {},
                ),
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Título: ${widget.video.title}',
            //       style:
            //           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //     SizedBox(height: 8),
            //     Text('Descripción: ${widget.video.descriptionVideo}'),
            //     SizedBox(height: 8),
            //     Text('Nombre: ${widget.video.name}'),
            //     SizedBox(height: 8),
            //     Text('Fecha de Grabación: ${widget.video.timeRecoded}'),
            //     SizedBox(height: 16),
            //     Text(
            //       'Miniaturas:',
            //       style:
            //           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //     ),
            //     SizedBox(height: 8),

            //     Container(
            //       height: 100,
            //       child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: widget.video.listThumbnail.length,
            //         itemBuilder: (context, index) {
            //           final thumbnail = widget.video.listThumbnail[index];
            //           return Padding(
            //             padding: EdgeInsets.only(right: 8),
            //             child: Image.memory(thumbnail.imageUrl),
            //           );
            //         },
            //       ),
            //     ),
            //     SizedBox(height: 16),
            //     Text(
            //       'Grabaciones:',
            //       style:
            //           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //     ),
            //     SizedBox(height: 8),
            //     GridView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         mainAxisSpacing: 8,
            //         crossAxisSpacing: 8,
            //       ),
            //       itemCount: widget.video.listRecoded?.length ?? 0,
            //       itemBuilder: (context, index) {
            //         final recoded = widget.video.listRecoded![index];
            //         return Card(
            //           child: Padding(
            //             padding: EdgeInsets.all(8),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Título: ${recoded.titleThumb}'),
            //                 SizedBox(height: 4),
            //                 Text('Fecha: ${recoded.timeRecoded}'),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
