
import 'package:artlab_service/model/msglist_model.dart';

class ResModel {
  List<MsgList>? msgList;
  dynamic value;
  bool? success;

  ResModel({
    this.msgList,
    this.value,
    this.success
  });
  ResModel.fromJson(Map<String, dynamic> json) {
      msgList = json["msgList"] == null ? [] : List<MsgList>.from(json["msgList"]!.map((x) => MsgList.fromJson(x)));
      success = json["success"];
  }
  Map<String, dynamic> toJson() => {
      "success": success,
      "msgList": msgList == null ? [] : List<dynamic>.from(msgList!.map((x) => x.toJson())),
  };
}