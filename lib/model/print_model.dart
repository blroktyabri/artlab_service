import 'package:artlab_service/model/res_model.dart';

class PrintModel extends ResModel {
  PrintModel({
    super.msgList,
    super.value,
    super.success
  });

  PrintModel.fromJson(Map<String, dynamic> json)
    : super.fromJson(json) {
      value = json['value'];
    }
}