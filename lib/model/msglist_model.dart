class MsgListErr {
  List<MsgList>? msgList;

  MsgListErr({this.msgList});

  MsgListErr.fromJson(Map<String, dynamic> json) {
    if (json['msgList'] != null) {
      msgList = <MsgList>[];
      json['msgList'].forEach((v) {
        msgList?.add(MsgList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (msgList != null) {
      data['msgList'] = msgList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MsgList {
  String? code;

  MsgList({this.code});

  MsgList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}