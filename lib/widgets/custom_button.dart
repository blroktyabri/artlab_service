import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      margin: EdgeInsets.only(bottom: 25),
      clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
        color: Color.fromARGB(224, 21, 111, 180),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: TextButton( 
        onPressed: () => onPressed(),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF156FB4)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    );
  }
}