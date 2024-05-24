import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextWidget extends StatelessWidget
{
  final TextEditingController textEditingController;
  final IconData? iconData;
  final String? assetReference;
  final String lableString;
  final bool isObscure;


  InputTextWidget (
  {
    required this.textEditingController,
    this.iconData,
    this.assetReference,
    required this.lableString,
    required this.isObscure,
});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: lableString,
        prefixIcon: iconData != null
            ? Icon(
          iconData,
          color: Colors.black,
        )
            : Padding(
                padding : const EdgeInsets.all(8),
                child: Image.asset(assetReference!, width: 10,),
        ),
        labelStyle: GoogleFonts.anekTelugu(
          fontSize: 18,
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black26)),
      ),
      obscureText: isObscure,
      style: GoogleFonts.anekTelugu(
        color: Colors.black,
      ),
    );
  }
}
