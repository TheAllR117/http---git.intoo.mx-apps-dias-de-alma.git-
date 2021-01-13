import 'dart:convert';

Ciclo cicloFromJson(String str) => Ciclo.fromJson(json.decode(str));

String cicloToJson(Ciclo data) => json.encode(data.toJson());

class Ciclo {
  Ciclo({
    this.nid,
    this.uuid,
    this.vid,
    this.langcode,
    this.type,
    this.revisionTimestamp,
    this.revisionUid,
    this.revisionLog,
    this.status,
    this.uid,
    this.title,
    this.created,
    this.changed,
    this.promote,
    this.sticky,
    this.defaultLangcode,
    this.revisionTranslationAffected,
    this.path,
    this.contentTranslationSource,
    this.contentTranslationOutdated,
    this.body,
    this.comment,
    this.fieldArticleAudio,
    this.fieldArticleImagenh,
    this.fieldArticleSubtitulo,
    this.fieldArticleTextoPremium,
    this.fieldImage,
  });

  List<Nid> nid;
  List<ContentTranslationSource> uuid;
  List<Nid> vid;
  List<ContentTranslationSource> langcode;
  List<Type> type;
  List<Changed> revisionTimestamp;
  List<Uid> revisionUid;
  List<dynamic> revisionLog;
  List<ContentTranslationOutdated> status;
  List<Uid> uid;
  List<ContentTranslationSource> title;
  List<Changed> created;
  List<Changed> changed;
  List<ContentTranslationOutdated> promote;
  List<ContentTranslationOutdated> sticky;
  List<ContentTranslationOutdated> defaultLangcode;
  List<ContentTranslationOutdated> revisionTranslationAffected;
  List<Path> path;
  List<ContentTranslationSource> contentTranslationSource;
  List<ContentTranslationOutdated> contentTranslationOutdated;
  List<Body> body;
  List<Comment> comment;
  List<FieldArticleAudio> fieldArticleAudio;
  List<dynamic> fieldArticleImagenh;
  List<ContentTranslationSource> fieldArticleSubtitulo;
  List<Body> fieldArticleTextoPremium;
  List<dynamic> fieldImage;

  factory Ciclo.fromJson(Map<String, dynamic> json) => Ciclo(
        nid: List<Nid>.from(json["nid"].map((x) => Nid.fromJson(x))),
        uuid: List<ContentTranslationSource>.from(
            json["uuid"].map((x) => ContentTranslationSource.fromJson(x))),
        vid: List<Nid>.from(json["vid"].map((x) => Nid.fromJson(x))),
        langcode: List<ContentTranslationSource>.from(
            json["langcode"].map((x) => ContentTranslationSource.fromJson(x))),
        type: List<Type>.from(json["type"].map((x) => Type.fromJson(x))),
        revisionTimestamp: List<Changed>.from(
            json["revision_timestamp"].map((x) => Changed.fromJson(x))),
        revisionUid:
            List<Uid>.from(json["revision_uid"].map((x) => Uid.fromJson(x))),
        revisionLog: List<dynamic>.from(json["revision_log"].map((x) => x)),
        status: List<ContentTranslationOutdated>.from(
            json["status"].map((x) => ContentTranslationOutdated.fromJson(x))),
        uid: List<Uid>.from(json["uid"].map((x) => Uid.fromJson(x))),
        title: List<ContentTranslationSource>.from(
            json["title"].map((x) => ContentTranslationSource.fromJson(x))),
        created:
            List<Changed>.from(json["created"].map((x) => Changed.fromJson(x))),
        changed:
            List<Changed>.from(json["changed"].map((x) => Changed.fromJson(x))),
        promote: List<ContentTranslationOutdated>.from(
            json["promote"].map((x) => ContentTranslationOutdated.fromJson(x))),
        sticky: List<ContentTranslationOutdated>.from(
            json["sticky"].map((x) => ContentTranslationOutdated.fromJson(x))),
        defaultLangcode: List<ContentTranslationOutdated>.from(
            json["default_langcode"]
                .map((x) => ContentTranslationOutdated.fromJson(x))),
        revisionTranslationAffected: List<ContentTranslationOutdated>.from(
            json["revision_translation_affected"]
                .map((x) => ContentTranslationOutdated.fromJson(x))),
        path: List<Path>.from(json["path"].map((x) => Path.fromJson(x))),
        contentTranslationSource: List<ContentTranslationSource>.from(
            json["content_translation_source"]
                .map((x) => ContentTranslationSource.fromJson(x))),
        contentTranslationOutdated: List<ContentTranslationOutdated>.from(
            json["content_translation_outdated"]
                .map((x) => ContentTranslationOutdated.fromJson(x))),
        body: List<Body>.from(json["body"].map((x) => Body.fromJson(x))),
        comment:
            List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
        fieldArticleAudio: List<FieldArticleAudio>.from(
            json["field_article_audio"]
                .map((x) => FieldArticleAudio.fromJson(x))),
        fieldArticleImagenh:
            List<dynamic>.from(json["field_article_imagenh"].map((x) => x)),
        fieldArticleSubtitulo: List<ContentTranslationSource>.from(
            json["field_article_subtitulo"]
                .map((x) => ContentTranslationSource.fromJson(x))),
        fieldArticleTextoPremium: List<Body>.from(
            json["field_article_texto_premium"].map((x) => Body.fromJson(x))),
        fieldImage: List<dynamic>.from(json["field_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nid": List<dynamic>.from(nid.map((x) => x.toJson())),
        "uuid": List<dynamic>.from(uuid.map((x) => x.toJson())),
        "vid": List<dynamic>.from(vid.map((x) => x.toJson())),
        "langcode": List<dynamic>.from(langcode.map((x) => x.toJson())),
        "type": List<dynamic>.from(type.map((x) => x.toJson())),
        "revision_timestamp":
            List<dynamic>.from(revisionTimestamp.map((x) => x.toJson())),
        "revision_uid": List<dynamic>.from(revisionUid.map((x) => x.toJson())),
        "revision_log": List<dynamic>.from(revisionLog.map((x) => x)),
        "status": List<dynamic>.from(status.map((x) => x.toJson())),
        "uid": List<dynamic>.from(uid.map((x) => x.toJson())),
        "title": List<dynamic>.from(title.map((x) => x.toJson())),
        "created": List<dynamic>.from(created.map((x) => x.toJson())),
        "changed": List<dynamic>.from(changed.map((x) => x.toJson())),
        "promote": List<dynamic>.from(promote.map((x) => x.toJson())),
        "sticky": List<dynamic>.from(sticky.map((x) => x.toJson())),
        "default_langcode":
            List<dynamic>.from(defaultLangcode.map((x) => x.toJson())),
        "revision_translation_affected": List<dynamic>.from(
            revisionTranslationAffected.map((x) => x.toJson())),
        "path": List<dynamic>.from(path.map((x) => x.toJson())),
        "content_translation_source":
            List<dynamic>.from(contentTranslationSource.map((x) => x.toJson())),
        "content_translation_outdated": List<dynamic>.from(
            contentTranslationOutdated.map((x) => x.toJson())),
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
        "field_article_audio":
            List<dynamic>.from(fieldArticleAudio.map((x) => x.toJson())),
        "field_article_imagenh":
            List<dynamic>.from(fieldArticleImagenh.map((x) => x)),
        "field_article_subtitulo":
            List<dynamic>.from(fieldArticleSubtitulo.map((x) => x.toJson())),
        "field_article_texto_premium":
            List<dynamic>.from(fieldArticleTextoPremium.map((x) => x.toJson())),
        "field_image": List<dynamic>.from(fieldImage.map((x) => x)),
      };
}

class Body {
  Body({
    this.value,
    this.format,
    this.processed,
    this.summary,
  });

  String value;
  String format;
  String processed;
  String summary;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        value: json["value"],
        format: json["format"],
        processed: json["processed"],
        summary: json["summary"] == null ? null : json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "format": format,
        "processed": processed,
        "summary": summary == null ? null : summary,
      };
}

class Changed {
  Changed({
    this.value,
    this.format,
  });

  DateTime value;
  String format;

  factory Changed.fromJson(Map<String, dynamic> json) => Changed(
        value: DateTime.parse(json["value"]),
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "value": value.toIso8601String(),
        "format": format,
      };
}

class Comment {
  Comment({
    this.status,
    this.cid,
    this.lastCommentTimestamp,
    this.lastCommentName,
    this.lastCommentUid,
    this.commentCount,
  });

  int status;
  dynamic cid;
  dynamic lastCommentTimestamp;
  dynamic lastCommentName;
  dynamic lastCommentUid;
  dynamic commentCount;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        status: json["status"],
        cid: json["cid"],
        lastCommentTimestamp: json["last_comment_timestamp"],
        lastCommentName: json["last_comment_name"],
        lastCommentUid: json["last_comment_uid"],
        commentCount: json["comment_count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cid": cid,
        "last_comment_timestamp": lastCommentTimestamp,
        "last_comment_name": lastCommentName,
        "last_comment_uid": lastCommentUid,
        "comment_count": commentCount,
      };
}

class ContentTranslationOutdated {
  ContentTranslationOutdated({
    this.value,
  });

  bool value;

  factory ContentTranslationOutdated.fromJson(Map<String, dynamic> json) =>
      ContentTranslationOutdated(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class ContentTranslationSource {
  ContentTranslationSource({
    this.value,
  });

  String value;

  factory ContentTranslationSource.fromJson(Map<String, dynamic> json) =>
      ContentTranslationSource(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class FieldArticleAudio {
  FieldArticleAudio({
    this.targetId,
    this.display,
    this.description,
    this.targetType,
    this.targetUuid,
    this.url,
  });

  int targetId;
  bool display;
  String description;
  String targetType;
  String targetUuid;
  String url;

  factory FieldArticleAudio.fromJson(Map<String, dynamic> json) =>
      FieldArticleAudio(
        targetId: json["target_id"],
        display: json["display"],
        description: json["description"],
        targetType: json["target_type"],
        targetUuid: json["target_uuid"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "target_id": targetId,
        "display": display,
        "description": description,
        "target_type": targetType,
        "target_uuid": targetUuid,
        "url": url,
      };
}

class Nid {
  Nid({
    this.value,
  });

  int value;

  factory Nid.fromJson(Map<String, dynamic> json) => Nid(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Path {
  Path({
    this.alias,
    this.pid,
    this.langcode,
  });

  dynamic alias;
  dynamic pid;
  String langcode;

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        alias: json["alias"],
        pid: json["pid"],
        langcode: json["langcode"],
      );

  Map<String, dynamic> toJson() => {
        "alias": alias,
        "pid": pid,
        "langcode": langcode,
      };
}

class Uid {
  Uid({
    this.targetId,
    this.targetType,
    this.targetUuid,
    this.url,
  });

  int targetId;
  String targetType;
  String targetUuid;
  String url;

  factory Uid.fromJson(Map<String, dynamic> json) => Uid(
        targetId: json["target_id"],
        targetType: json["target_type"],
        targetUuid: json["target_uuid"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "target_id": targetId,
        "target_type": targetType,
        "target_uuid": targetUuid,
        "url": url,
      };
}

class Type {
  Type({
    this.targetId,
    this.targetType,
    this.targetUuid,
  });

  String targetId;
  String targetType;
  String targetUuid;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        targetId: json["target_id"],
        targetType: json["target_type"],
        targetUuid: json["target_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "target_id": targetId,
        "target_type": targetType,
        "target_uuid": targetUuid,
      };
}
