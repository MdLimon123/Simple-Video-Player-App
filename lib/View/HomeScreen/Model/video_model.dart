// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  final Links links;
  final int total;
  final int page;
  final int pageSize;
  final List<Result> results;

  VideoModel({
    required this.links,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.results,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        links: Links.fromJson(json["links"] ?? ""),
        total: json["total"],
        page: json["page"],
        pageSize: json["page_size"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links": links.toJson(),
        "total": total,
        "page": page,
        "page_size": pageSize,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Links {
  final dynamic next;
  final dynamic previous;

  Links({
    required this.next,
    required this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"] ?? "",
        previous: json["previous"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
      };
}

class Result {
  final String thumbnail;
  final int id;
  final String title;
  final DateTime dateAndTime;
  final String slug;
  final DateTime createdAt;
  final String manifest;
  final int liveStatus;
  final String liveManifest;
  final bool isLive;
  final String channelImage;
  final String channelName;
  final String channelUsername;
  final bool isVerified;
  final String channelSlug;
  final String channelSubscriber;
  final int channelId;
  final String type;
  final String viewers;
  final String duration;
  final ObjectType objectType;

  Result({
    required this.thumbnail,
    required this.id,
    required this.title,
    required this.dateAndTime,
    required this.slug,
    required this.createdAt,
    required this.manifest,
    required this.liveStatus,
    required this.liveManifest,
    required this.isLive,
    required this.channelImage,
    required this.channelName,
    required this.channelUsername,
    required this.isVerified,
    required this.channelSlug,
    required this.channelSubscriber,
    required this.channelId,
    required this.type,
    required this.viewers,
    required this.duration,
    required this.objectType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        thumbnail: json["thumbnail"],
        id: json["id"],
        title: json["title"],
        dateAndTime: DateTime.parse(json["date_and_time"]),
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        manifest: json["manifest"],
        liveStatus: json["live_status"],
        liveManifest: json["live_manifest"] ?? "",
        isLive: json["is_live"],
        channelImage: json["channel_image"],
        channelName: json["channel_name"],
        channelUsername: json["channel_username"] ?? "",
        isVerified: json["is_verified"],
        channelSlug: json["channel_slug"],
        channelSubscriber: json["channel_subscriber"],
        channelId: json["channel_id"],
        type: json["type"],
        viewers: json["viewers"],
        duration: json["duration"],
        objectType: objectTypeValues.map[json["object_type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "id": id,
        "title": title,
        "date_and_time": dateAndTime.toIso8601String(),
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "manifest": manifest,
        "live_status": liveStatus,
        "live_manifest": liveManifest,
        "is_live": isLive,
        "channel_image": channelImage,
        "channel_name": channelName,
        "channel_username": channelUsername,
        "is_verified": isVerified,
        "channel_slug": channelSlug,
        "channel_subscriber": channelSubscriber,
        "channel_id": channelId,
        "type": type,
        "viewers": viewers,
        "duration": duration,
        "object_type": objectTypeValues.reverse[objectType],
      };
}

enum ObjectType { VIDEO }

final objectTypeValues = EnumValues({"video": ObjectType.VIDEO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
