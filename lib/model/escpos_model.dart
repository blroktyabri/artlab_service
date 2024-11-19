import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart' as utils;


class EscPosModel {
    List<List<Value>> value;

    EscPosModel({
        required this.value,
    });

    factory EscPosModel.fromJson(Map<String, dynamic> json) => EscPosModel(
        value: List<List<Value>>.from(json["value"].map((x) => List<Value>.from(x.map((x) => Value.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "value": List<dynamic>.from(value.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    };
}

class Value {
    Type? type;
    String? url;
    int? width;
    utils.PosAlign? align;
    int? bold;
    int? fonttype;
    String? text;
    String? message;

    Value({
        required this.type,
        this.url,
        this.width,
        this.align,
        this.bold,
        this.fonttype,
        this.text,
        this.message,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        type: typeValues.map[json["type"]],
        url: json["url"],
        width: json["width"],
        align: alignValues.map[json["align"]],
        bold: json["bold"],
        fonttype: json["fonttype"],
        text: json["text"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "url": url,
        "width": width,
        "align": alignValues.reverse[align],
        "bold": bold,
        "fonttype": fonttype,
        "text": text,
        "message": message,
    };
}

enum PosAlign {
    center,
    left,
    right
}

final alignValues = EnumValues({
    "center": utils.PosAlign.center,
    "left": utils.PosAlign.left,
    "right": utils.PosAlign.right
});

enum Type {
    IMAGE,
    QR_CODE,
    TEXT
}

final typeValues = EnumValues({
    "image": Type.IMAGE,
    "qr_code": Type.QR_CODE,
    "text": Type.TEXT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}