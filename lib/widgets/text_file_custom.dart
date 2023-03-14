import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remoteraspy/common/enums.dart';
import 'package:remoteraspy/common/validate.dart';

class TextFileCustom extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final ValidateText? validateText;
  final bool isPass;

  const TextFileCustom({
    Key? key,
    required this.title,
    required this.controller,
    this.validateText,
    this.isPass = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: controller,
            maxLength: validateMaxLength(),
            obscureText: isPass,
            inputFormatters: [validateInputFormatters()],
            validator: (String? value){
              return validateData(value);
            },
          )
        ],
      ),
    );
  }

  validateMaxLength(){
    switch(validateText){
      case ValidateText.email:
        return 64;
      case ValidateText.phoneNumber:
        return 15;
      case ValidateText.text:
        return 500;
      default:
        return 40;
    }
  }

  validateInputFormatters(){
    switch(validateText){
      case ValidateText.phoneNumber:
        return FilteringTextInputFormatter.digitsOnly;
      default:
        return FilteringTextInputFormatter.singleLineFormatter;
    }
  }

  validateData(String? text){
    switch(validateText){
      case ValidateText.email:
        return validateEmail(text!)?null:"No es un correo";
      case ValidateText.phoneNumber:
        return validateNumberPhone(text!)?null:"No es un numero telefonico";
      default:
        return validateTextNull(text)?null:"El campo esta vacio";
    }
  }

}
