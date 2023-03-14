validateEmail(String text){
  if(text.trim().isEmpty) return false;
  String exp = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  return RegExp(exp).hasMatch(text);
}

validateNumberPhone(String text){
  if(text.trim().isEmpty) return false;
  String exp = r"^(?:[+0]9)?[0-9]{10,15}$";
  return RegExp(exp).hasMatch(text);
}

validateTextNull(String? text){
  if (text == null) return false;
  return text!.trim().isNotEmpty;
}