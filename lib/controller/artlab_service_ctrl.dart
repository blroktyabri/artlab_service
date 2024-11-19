import 'dart:convert';
import 'dart:typed_data';
import 'package:artlab_service/cache/cache_manager.dart';
import 'package:artlab_service/dialog/dialog_popup.dart';
import 'package:artlab_service/model/escpos_model.dart';
import 'package:artlab_service/model/print_model.dart';
import 'package:artlab_service/model/res_model.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:windows_usb_printer/windows_usb_printer.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart' as utils;

class DirectController extends GetxController {
  final Dio dio = Dio();
  CacheManager cacheManager = CacheManager();
  List<WindowsPrinterInfo> printerList = [];
  var printerName = 'Холбогдсон принтер олдсонгүй.'.obs;

  scan() async {
    printerList = (await WindowsUsbPrinterProvider.queryLocalUsbDevice())!;
    printerName.value = printerList.first.pPrinterName;
  }

  Future<void> checkToken(String token) async {
    var res = await dio.get(
      'https://api.example.com/check_token',
      options: Options(
        headers: {
          'direct-print-token' : token.replaceRange(token.length-2, token.length, '')
        }
      )
    );
    if(ResModel.fromJson(res.data).success!) {
      cacheManager.updateToken(token);
      const snackBar = SnackBar(
        content: Text('Токен идэвхитэй байна. Хэвлэхэд бэлэн.'),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar); 
    } else {
      debugPrint('invalid token');
      return showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return DialogPopup(
            dialogText: 'Токен буруу байна.', 
            dialogImg: 'assets/images/popup/warning.png',
            rightBtnText: 'Буцах',
            rightBtnFunc: () {
              Get.back();
            }
          );
        }
      );
    }
  }

  printTestPage() async {
    final profile = await utils.CapabilityProfile.load();
    final generator = utils.Generator(utils.PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.text('Ready to print',);
    bytes += generator.feed(2);
    bytes += generator.cut();
    //await WindowsUsbPrinterProvider.usbWrite(printerName.value, bytes);
  }

  Future<void> getPrintJob() async {
    final profile = await utils.CapabilityProfile.load();
    final generator = utils.Generator(utils.PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.setGlobalCodeTable('CP866');
    Future<Uint8List> getEncoded(String data) async {
      final encoded = await CharsetConverter.encode("CP866", data);
      return encoded;
    }

    final res = await dio.get(
      'https://api.artlab.mn/inner/pos/direct-print/u/get-print-job',
      options: Options(
        headers: {
          'direct-print-token' : cacheManager.getToken()!.replaceRange(cacheManager.getToken()!.length-2, cacheManager.getToken()!.length, '')
        }
      )
    );
    final jsonString = PrintModel.fromJson(res.data).value;
    if(res.statusCode == 200 && jsonString != null) {
      var jsonData = jsonDecode(jsonString);
      var printData = {
        "value" : jsonData
      };
      if(EscPosModel.fromJson(printData).value.isNotEmpty) {
        for (var data in EscPosModel.fromJson(printData).value) {
          for (var bill in data) {
            if(bill.type == Type.IMAGE) {
              var res = await http.get(Uri.parse(bill.url!));
              final img.Image image = img.decodeImage(res.bodyBytes)!;
              final img.Image resized = img.copyResize(image, width: 380);
              bytes += generator.image(resized);
            }
            if(bill.type == Type.TEXT && bill.text!.isEmpty == false) {
              var encoded = await getEncoded(bill.text.toString());
              bytes += generator.textEncoded(encoded, styles: utils.PosStyles(align: bill.align ?? utils.PosAlign.left));
            }
            if(bill.type == Type.QR_CODE) {
              const double qrSize = 300;
              try {
                final uiImg = await QrPainter(
                  data: bill.message!,
                  version: QrVersions.auto,
                  gapless: false,
                ).toImageData(qrSize);
                final Uint8List uint8list = uiImg!.buffer.asUint8List();
                final img.Image image = img.decodeImage(uint8list)!;
                bytes += generator.image(image);
              } catch (e) {
                debugPrint(e.toString());
              }
            }
          }
          bytes += generator.feed(2);
          bytes += generator.cut();
        }
      }
      await WindowsUsbPrinterProvider.usbWrite(printerName.value, bytes);
    }
  }
 
  test() async {
    final profile = await utils.CapabilityProfile.load();
    final generator = utils.Generator(utils.PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.text('Ready to print',);
    bytes += generator.feed(2);
    bytes += generator.cut();
    await WindowsUsbPrinterProvider.usbWrite(printerName.value, bytes);
  }
}