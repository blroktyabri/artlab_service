import 'dart:async';
import 'package:artlab_service/cache/cache_manager.dart';
import 'package:artlab_service/controller/artlab_service_ctrl.dart';
import 'package:artlab_service/widgets/custom_button.dart';
import 'package:artlab_service/widgets/custom_dropdown.dart';
import 'package:artlab_service/widgets/custom_text.dart';
import 'package:artlab_service/widgets/custom_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windows_usb_printer/windows_usb_printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        body: ArtLabService(),
      )
    );
  }
}

class ArtLabService extends StatefulWidget {
  const ArtLabService({super.key});

  @override
  State<ArtLabService> createState() => _ArtLabServiceState();
}

class _ArtLabServiceState extends State<ArtLabService> {
  DirectController directController = Get.put(DirectController());
  Timer? _periodicTimer;
  List<WindowsPrinterInfo> printerList = [];
  final dio = Dio();
  var status = 'Токеноо шалгана уу';
  TextEditingController tokenController = TextEditingController();
  CacheManager cacheManager = CacheManager();

  @override
  void initState() {
    //directController.scan();
    super.initState();
    tokenController.text = cacheManager.getToken() ?? 'empty';
  }

  void _startListenAPI() async {
    const oneSecond = Duration(seconds: 3);
    _periodicTimer = Timer.periodic(oneSecond, (Timer timer) async {
      setState(() {
        status = 'Сонсож байна';
      });
      debugPrint('started');
      directController.getPrintJob();
    });
  }

  void _endListenAPI() {
    debugPrint('stopped');
    setState(() {
      status = 'Сонсож дууссан';
    });
    _periodicTimer?.cancel();
  }

  @override
  void dispose() {
    _periodicTimer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 45,
          left: 40,
          child: Column(
            children: const [
              CustomText(text: 'Токен'),
              SizedBox(height: 10,),
              CustomText(text: 'Принтер',)
            ],
          )
        ),
        Positioned(
          top: 40,
          left: 230,
          child: Column(
            children: [
              CustomTextField(controller: tokenController,),
              CustomDropdown(printerName: directController.printerName.value,),
            ],
          )
        ),
        Positioned(
          top: 45,
          left: 630,
          child: Column(
            children: [
              CustomButton(
                title: 'шалгах', 
                onPressed: () => directController.checkToken(tokenController.text),
              ),
              CustomButton(
                title: 'тест', 
                onPressed: () => directController.printTestPage(),
              )
            ],
          )
        ),
        Positioned(
          top: 150,
          left: 280,
          child: Column(
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: Text('Статус:   $status', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
              ),
              CustomButton(
                title: 'Эхлэх', 
                onPressed: () => {
                  _startListenAPI()
                }
              ),
              CustomButton(
                title: 'Дуусгах', 
                onPressed: () => {
                  _endListenAPI()
                }
              )
            ],
          )
        ),
      ],
    );
  }
}