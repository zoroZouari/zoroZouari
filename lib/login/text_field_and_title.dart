import 'package:flutter/material.dart';

class TextFieldAndTitle extends StatelessWidget {
  const TextFieldAndTitle({super.key,
   required this.title,
   required this.hintText,
   this.isShowPassword,
   this.suffixIcon,
   required this.validator,
   this.helperText,
   required this.controller,
   });
  final String title;
  final String hintText;
  final bool? isShowPassword;
  final Widget? suffixIcon;
  final String? Function (String? value) validator;
  final String? helperText;
  final TextEditingController controller;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:const TextStyle(
            fontSize: 25,
          )
          ),
        TextFormField(
          textInputAction: TextInputAction.next,
          validator: validator ,
          controller: controller,
          obscureText: isShowPassword ?? false,
          decoration:  InputDecoration(
             border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.black),
                ),
              filled: true,
             fillColor: Colors.white,
            suffix: suffixIcon,
            hintText: hintText,
            helperText: helperText,
            helperMaxLines:3,
            errorMaxLines: 3,
            enabledBorder:const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green.shade900,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}