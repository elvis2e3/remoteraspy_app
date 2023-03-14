import 'package:get/get.dart';
import 'package:remoteraspy/pages/login_page.dart';
import 'package:remoteraspy/pages/index_page.dart';
// import 'package:myforms/pages/view_page.dart';
// import 'package:myforms/pages/form_page.dart';


List<GetPage>getRoutes() {
  return [
     GetPage(name: "/", page: () => LoginPage()),
     GetPage(name: "/index/", page: () => IndexPage()),
     // GetPage(name: "/view/", page: () => ViewPage()),
     // GetPage(name: "/form/", page: () => FormPage()),
  ];
}
