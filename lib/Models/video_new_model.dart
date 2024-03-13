import 'dart:convert';
import 'dart:typed_data';

import 'package:Klasspadel/Models/recoded_model.dart';

import 'package:Klasspadel/Models/thumbnail.dart';

class Video {
  String urlVideo;
  String title;
  String descriptionVideo;
  String name;
  String imgage;
  String time;
  List<Thumbnail> listThumbnail;
  DateTime timeRecoded;
  List<RecodedModel>? listRecoded;

  Video({
    required this.urlVideo,
    required this.title,
    required this.descriptionVideo,
    required this.name,
    required this.imgage,
    required this.time,
    required this.listThumbnail,
    required this.timeRecoded,
    this.listRecoded,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    List<dynamic> thumbnailJsonList = json['listThumbnail'] ?? [];
    List<Thumbnail> thumbnails = thumbnailJsonList
        .map((thumbnailJson) => Thumbnail.fromJson(thumbnailJson))
        .toList();

    List<dynamic>? recordedJsonList = json['listRecoded'];
    List<RecodedModel>? recorded;
    if (recordedJsonList != null) {
      recorded = recordedJsonList
          .map((recordedJson) => RecodedModel.fromJson(recordedJson))
          .toList();
    }

    return Video(
      urlVideo: json['urlVideo'],
      title: json['title'],
      descriptionVideo: json['descriptionVideo'],
      name: json['name'],
      imgage: json['imgage'],
      time: json['time'],
      listThumbnail: thumbnails,
      timeRecoded: DateTime.parse(json['timeRecoded']),
      listRecoded: recorded,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> thumbnailJsonList =
        listThumbnail.map((thumbnail) => thumbnail.toJson()).toList();

    List<Map<String, dynamic>>? recordedJsonList;
    if (listRecoded != null) {
      recordedJsonList =
          listRecoded!.map((recorded) => recorded.toJson()).toList();
    }

    return {
      'urlVideo': urlVideo,
      'title': title,
      'descriptionVideo': descriptionVideo,
      'name': name,
      'imgage': imgage,
      'time': time,
      'listThumbnail': thumbnailJsonList,
      'timeRecoded': timeRecoded.toIso8601String(),
      'listRecoded': recordedJsonList,
    };
  }

//   Video toVideo() {
//     return Video(
//       urlVideo: urlVideo,
//       title: title,
//       descriptionVideo: descriptionVideo,
//       name: name,
//       image: base64Decode(imgage),
//       time: time,
//       listThumbnail: listThumbnail
//           .map((thumbnail) => Thumbnail(
//                 timeMs: thumbnail.timeMs,
//                 imageUrl: base64Decode(thumbnail.imageUrl),
//                 titleThumb: thumbnail.titleThumb,
//                 descriptionThumb: thumbnail.descriptionThumb,
//                 timeCapture: thumbnail.timeCapture,
//                 recoderUrl: thumbnail.recoderUrl != null
//                     ? base64Decode(thumbnail.recoderUrl!)
//                     : null,
//                 timeDurationRecoded: thumbnail.timeDurationRecoded,
//                 titleRecoded: thumbnail.titleRecoded,
//                 recoderPath: thumbnail.recoderPath,
//               ))
//           .toList(),
//       timeRecorded: timeRecoded,
//       listRecorded: listRecoded
//           ?.map((recorded) => Recorded(
//                 timeMs: recorded.timeMs,
//                 titleThumb: recorded.titleThumb,
//                 timeRecoded: recorded.timeRecoded,
//                 recoderUrl: recorded.recoderUrl != null
//                     ? base64Decode(recorded.recoderUrl!)
//                     : null,
//               ))
//           .toList(),
//     );
//   }
}

// class Thumbnail {
//   int timeMs;
//   Uint8List imageUrl;
//   String titleThumb;
//   String descriptionThumb;
//   DateTime timeCapture;
//   Uint8List? recoderUrl;
//   String timeDurationRecoded;
//   String titleRecoded;
//   String? recoderPath;

//   Thumbnail({
//     required this.timeMs,
//     required this.imageUrl,
//     required this.titleThumb,
//     required this.descriptionThumb,
//     required this.timeCapture,
//     required this.recoderUrl,
//     required this.timeDurationRecoded,
//     required this.titleRecoded,
//     required this.recoderPath,
//   });

//   factory Thumbnail.fromJson(Map<String, dynamic> json) {
//     return Thumbnail(
//       timeMs: json['timeMs'],
//       imageUrl: base64Decode(json['imageUrl']),
//       titleThumb: json['titleThumb'],
//       descriptionThumb: json['descriptionThumb'],
//       timeCapture: DateTime.parse(json['timeCapture']),
//       recoderUrl:
//           json['recoderUrl'] != null ? base64Decode(json['recoderUrl']) : null,
//       timeDurationRecoded: json['timeDurationRecoded'],
//       titleRecoded: json['titleRecoded'],
//       recoderPath: json['recoderPath'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'timeMs': timeMs,
//       'imageUrl': base64Encode(imageUrl),
//       'titleThumb': titleThumb,
//       'descriptionThumb': descriptionThumb,
//       'timeCapture': timeCapture.toIso8601String(),
//       'recoderUrl': recoderUrl != null ? base64Encode(recoderUrl!) : null,
//       'timeDurationRecoded': timeDurationRecoded,
//       'titleRecoded': titleRecoded,
//       'recoderPath': recoderPath,
//     };
//   }
// }

class Recoded {
  int timeMs;
  String titleThumb;
  DateTime timeRecoded;
  Uint8List? recoderUrl;

  Recoded({
    required this.timeMs,
    required this.titleThumb,
    required this.timeRecoded,
    required this.recoderUrl,
  });

  factory Recoded.fromJson(Map<String, dynamic> json) {
    return Recoded(
      timeMs: json['timeMs'],
      titleThumb: json['titleThumb'],
      timeRecoded: DateTime.parse(json['timeRecoded']),
      recoderUrl:
          json['recoderUrl'] != null ? base64Decode(json['recoderUrl']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeMs': timeMs,
      'titleThumb': titleThumb,
      'timeRecoded': timeRecoded.toIso8601String(),
      'recoderUrl': recoderUrl != null ? base64Encode(recoderUrl!) : null,
    };
  }
}
