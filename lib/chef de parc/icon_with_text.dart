import'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  const IconWithText({super.key, 
  required this.icon,
   required this.text,
   this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Small text above the icon
        Text(
          text,
          style:TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF293F49),
          ),
          ),
        SizedBox(height: 8),
        //Icon
        IconButton(icon:const Icon(Icons.ac_unit_rounded, size:40,
        ),
        onPressed: onPressed,
        ),
      ],
    );
  }
}