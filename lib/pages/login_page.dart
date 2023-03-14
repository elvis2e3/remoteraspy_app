import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remoteraspy/widgets/text_file_custom.dart';
import 'package:remoteraspy/common/enums.dart';
import 'package:remoteraspy/api/client_api.dart';
import 'package:remoteraspy/share_prefs/app_pref.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController ctrlUrl = TextEditingController();
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    AppPref pref = AppPref();
    if(pref.url != "" ){
      ctrlUrl.text = pref.url;
    }
    Size size = Get.size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        width: size.width,
        height: size.height,
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              Center(
                child: Text(
                  "Remote Raspy",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                  ),
                ),
              ),
              SizedBox(height: 50,),
              TextFileCustom(
                title: "Host",
                controller: ctrlUrl,
                validateText: ValidateText.text,
              ),
              SizedBox(height: 10,),
              Container(
                width: size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if(keyForm.currentState!.validate()){
                      final reponse = await ApiClient().getSize(
                        ctrlUrl.text
                      );
                      if(reponse.status){
                        pref.url = ctrlUrl.text;
                        Get.toNamed('/index/');
                      }else{
                        Get.defaultDialog(
                          title: "Error",
                          content: Text("Datos Incorrectos!!")
                        );
                      }
                    }
                  },
                  child: const Text("Entrar")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

