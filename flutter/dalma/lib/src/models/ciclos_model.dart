import 'dart:convert';

Respueta respuetaFromJson(String str) => Respueta.fromJson(json.decode(str));

String respuetaToJson(Respueta data) => json.encode(data.toJson());

class Respueta {
  Respueta({
    this.title,
    this.body,
    this.fieldImage,
    this.fieldArticleTextoPremium,
    this.fieldArticleSubtitulo,
    this.fieldArticleAudio,
  });

  List<Title> title;

  List<Body> body;

  List<FieldImage> fieldImage;

  List<FieldArticleTextoPremium> fieldArticleTextoPremium;

  List<FieldArticleSubtitulo> fieldArticleSubtitulo;

  List<FieldArticleAudio> fieldArticleAudio;

  factory Respueta.fromJson(Map<String, dynamic> json) => Respueta(
        body: List<Body>.from(json["body"].map((x) => Body.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class Title {
  Title({
    this.value,
  });

  String value;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Body {
  String value;
  String format;
  String processed;
  String summary;

  Body({
    this.value,
    this.format,
    this.processed,
    this.summary,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        value: json["value"],
        format: json["format"],
        processed: json["processed"],
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "format": format,
        "processed": processed,
        "summary": summary,
      };
}

class FieldImage {
  FieldImage({
    this.targetId,
    this.alt,
    this.title,
    this.width,
    this.height,
    this.targetType,
    this.targetUuid,
    this.url,
  });

  int targetId;
  String alt;
  String title;
  int width;
  int height;
  String targetType;
  String targetUuid;
  String url;

  factory FieldImage.fromJson(Map<String, dynamic> json) => FieldImage(
        targetId: json["target_id"],
        alt: json["alt"],
        title: json["title"],
        width: json["width"],
        height: json["height"],
        targetType: json["target_type"],
        targetUuid: json["target_uuid"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "target_id": targetId,
        "alt": alt,
        "title": title,
        "width": width,
        "height": height,
        "target_type": targetType,
        "target_uuid": targetUuid,
        "url": url,
      };
}

class FieldArticleTextoPremium {
  FieldArticleTextoPremium({
    this.value,
    this.format,
    this.processed,
  });

  String value;
  String format;
  String processed;

  factory FieldArticleTextoPremium.fromJson(Map<String, dynamic> json) =>
      FieldArticleTextoPremium(
        value: json["value"],
        format: json["format"],
        processed: json["processed"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "format": format,
        "processed": processed,
      };
}

class FieldArticleSubtitulo {
  FieldArticleSubtitulo({
    this.value,
  });

  String value;

  factory FieldArticleSubtitulo.fromJson(Map<String, dynamic> json) =>
      FieldArticleSubtitulo(
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
