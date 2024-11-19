import 'dart:ui';
import 'package:flutter/material.dart';

class DialogPopup extends StatelessWidget {
  final String dialogText;
  final String dialogImg;
  final String? leftBtnText;
  final Function()? leftBtnFunc;
  final String rightBtnText;
  final Function() rightBtnFunc;
  const DialogPopup({super.key, required this.dialogText, required this.dialogImg, this.leftBtnText, this.leftBtnFunc, required this.rightBtnText, required this.rightBtnFunc});

  @override
  Widget build(BuildContext context) {
   // debugPrint('leftBtnText $leftBtnText');
    var width = MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2,
        sigmaY: 2
      ),
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        insetPadding: const EdgeInsets.all(7),
        contentPadding: const EdgeInsets.only(left: 1, right: 1,),
        content: SizedBox(
          height: height/2,
          width: width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.62,
                height: height * 0.25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode( Color.fromARGB(60, 21, 111, 180), BlendMode.srcIn,),
                    image: AssetImage('assets/images/ellipse.png',),
                    fit: BoxFit.fitWidth,
                    opacity: 0.1,
                  ),
                ),
                child: Container(
                  width: width * 0.31,
                  height: height * 0.15, //122
                  margin: const EdgeInsets.all(30),
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(dialogImg),
                      fit: BoxFit.contain
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.7,
                child: Text(
                  dialogText,
                  maxLines: 6,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF7D7D7D),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftBtnText == null
                    ? const SizedBox()
                    : Container(
                      width: width * 0.33,
                      height: 48,
                      margin: const EdgeInsets.only(bottom: 7),
                      decoration: ShapeDecoration(
                          color: const Color.fromARGB(222, 185, 28, 28),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                          ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          leftBtnFunc!();
                        }, 
                        child: Text(
                          leftBtnText!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                          ),
                        )
                      ),
                    ),
                    Container(
                      width:leftBtnText == null ? width * 0.7 : width * 0.33,
                      height: 48,
                      margin: const EdgeInsets.only(bottom: 7),
                      decoration: ShapeDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                          ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          rightBtnFunc();
                        }, 
                        child: Text(
                          rightBtnText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0.11,
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}