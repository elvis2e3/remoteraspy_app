import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remoteraspy/controllers/config_controller.dart';
import 'package:remoteraspy/share_prefs/app_pref.dart';
import 'package:remoteraspy/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = AppPref();
  await pref.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pref = AppPref();
    final configCtrl = Get.put(ConfigController());
    if(pref.isDarkMode){
      configCtrl.theme.value = configCtrl.themeDark.value;
    }else{
      configCtrl.theme.value = configCtrl.themeLight.value;
    }

    return Obx((){
      return GetMaterialApp(
        title: 'Remote Raspy',
        theme: configCtrl.theme.value,
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        initialRoute: pref.rutaPage,
        getPages: getRoutes(),
      );
    });
  }
}