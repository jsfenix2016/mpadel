import 'dart:io' as io;
import 'dart:io';

import 'package:Klasspadel/Models/thumbnail.dart';

import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/container_list_recoder.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/edit_button_expand.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/recoded_count.dart';
import 'package:Klasspadel/WidgetsCustom/WidgetsEditionControlle/zoom_custom.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_voice_recorder/flutter_voice_recorder.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:painter/painter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'package:audio_session/audio_session.dart';

import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

const theSource = AudioSource.microphone;

class EditControllCustom extends StatefulWidget {
  const EditControllCustom(
      {super.key,
      required this.onChanged,
      required this.onDelete,
      required this.listThumb,
      required this.onShowThumb,
      required this.nameAudio,
      required this.onPreview,
      required this.onSavePublish});

  static PainterController newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  final List<Thumbnail> listThumb;
  final ValueChanged<Thumbnail> onChanged;
  final ValueChanged<int> onDelete;
  final ValueChanged<int> onShowThumb;
  final ValueChanged<bool> onPreview;
  final ValueChanged<bool> onSavePublish;
  final String nameAudio;
  @override
  State<EditControllCustom> createState() => _EditControllCustomState();
}

class _EditControllCustomState extends State<EditControllCustom> {
  late PainterController controller = EditControllCustom.newController();
  WidgetsToImageController controllerWidget = WidgetsToImageController();
  // late FlutterSoundRecorder recordingSession;
  late AssetsAudioPlayer recordingPlayer = AssetsAudioPlayer();
  String pathToAudio = '';
  // late FlutterVoiceRecorder recodervoice;
  int elapsedTime = 0;

  List<Thumbnail> listRecoded = [];
  Thumbnail? thumbnailTemp;
  bool isrecoded = false;
  bool zoomActived = false;
  bool isedit = false;
  bool showlist = false;
  late io.Directory appDocumentsDirectory;

  Codec _codec = Codec.pcm16WAV;
  String _mPath = 'tau_file.wav';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();

    listRecoded = widget.listThumb;
    initThumbnails();
    initializerRecoder();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.aacMP4;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: thumbnailTemp!.pathRecoded,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: thumbnailTemp!.pathRecoded,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void initThumbnails() {
    thumbnailTemp = Thumbnail(
        timeMs: 0.toString(),
        imageUrl: Uint8List(0),
        descriptionThumb: "",
        titleThumb: "",
        timeCapture: DateTime.now().toIso8601String(),
        pathRecoded: '',
        timeDurationRecoded: '',
        titleRecoded: '');
  }

  @override
  void dispose() {
    // recordingSession.closeRecorderCompleted(0, true);
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  void initializerRecoder() async {
    // thumbnailTemp = Thumbnail(
    //     timeMs: 0.toString(),
    //     imageUrl: Uint8List(0),
    //     descriptionThumb: "",
    //     titleThumb: "",
    //     timeCapture: DateTime.now().toIso8601String(),
    //     pathRecoded: '',
    //     timeDurationRecoded: '',
    //     titleRecoded: '');
    await Permission.microphone.request();

    if (io.Platform.isAndroid) {
      appDocumentsDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocumentsDirectory = (await getTemporaryDirectory());
    }
    String filePath = '${appDocumentsDirectory.path}/${widget.nameAudio}.wav';
    File newVideoFile = File(filePath);
    pathToAudio = newVideoFile.path;

    thumbnailTemp!.pathRecoded = pathToAudio;
    _mPath = thumbnailTemp!.pathRecoded;

    await initializeDateFormatting();
  }

  Future<void> startRecording() async {
    elapsedTime = 0;

    String filePath = '${appDocumentsDirectory.path}/${widget.nameAudio}.wav';
    File newVideoFile = File(filePath);
    pathToAudio = newVideoFile.path;
    if (!appDocumentsDirectory.existsSync()) {
      appDocumentsDirectory.createSync();
    }
    print(filePath);
    thumbnailTemp!.pathRecoded = filePath;
    _mPath = filePath;
    record();
  }

  processVideoThumbnail() async {
    final bytes = await controllerWidget.capture();
    thumbnailTemp!.imageUrl = bytes;
    thumbnailTemp!.timeDurationRecoded = elapsedTime.toString();

    print(thumbnailTemp!.pathRecoded);
    controller.clear();
    widget.onChanged(thumbnailTemp!);
  }

  Future stopRecording() async {
    processVideoThumbnail();
    stopRecorder();
  }

  void previewVideo() async {
    widget.onPreview(true);
  }

  Future publish() async {
    widget.onSavePublish(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          WidgetsToImage(
            controller: controllerWidget,
            child: (isedit) ? Painter(controller) : const SizedBox.shrink(),
          ),
          ZoomCustom(
            zoomActived: zoomActived,
          ),
          Visibility(
            visible: showlist,
            child: ContainerListRecoder(
              listThumbnail: widget.listThumb,
              onDelete: (int value) {
                // listRecoded.removeAt(value);
                widget.onDelete(value);
              },
              onShowThumb: (int value) {
                widget.onShowThumb(value);
              },
              onClose: (bool value) {
                showlist = false;
                setState(() {});
              },
              left: 65.0,
            ),
          ),
          EditButtonExpand(
            onChanged: (PainterController value) {
              controller = value;

              if (isedit) {
                isedit = false;
              } else {
                isedit = true;
              }

              setState(() {});
            },
            onDelete: (bool value) {
              controller.clear;
              setState(() {});
            },
            onUndo: (void value) async {
              if (controller.isEmpty) {
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => const SizedBox(
                    height: 20,
                    child: Center(
                      child: Text('No tienes cambios'),
                    ),
                  ),
                );
              } else {
                controller.undo();
              }
            },
            onZoom: (bool value) {
              if (value) {
                zoomActived = false;
              } else {
                zoomActived = true;
              }
              setState(() {});
            },
            onPreview: (value) {
              previewVideo();
            },
            onList: (bool value) {
              if (showlist) {
                showlist = false;
              } else {
                showlist = true;
              }
              setState(() {});
            },
            onPublish: (value) => publish(),
          ),
          Visibility(
            visible: !showlist,
            child: Positioned(
              right: 10,
              child: RecoderCount(
                onChanged: (Duration value) async {
                  if (value.inSeconds == 0) {
                    startRecording();
                    isrecoded = true;
                  } else {
                    isrecoded = false;
                    elapsedTime = value.inSeconds;

                    await stopRecording();
                  }
                },
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [],
          ),
        ],
      ),
    );
  }
}
