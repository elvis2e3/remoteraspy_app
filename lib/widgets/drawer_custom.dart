import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remoteraspy/api/client_api.dart';
import 'package:remoteraspy/share_prefs/app_pref.dart';
import 'package:remoteraspy/controllers/data_controller.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient();
    Size size = Get.size;
    DataController dataController = Get.put(DataController());
    AppPref pref = AppPref();
    return Drawer(
      child:  Column(
        children: [
          Container(
            height: size.height * 0.25,
            child: DrawerHeader(
              child: Center(
                child: Text(
                  pref.url,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.red
              ),
            ),
          ),
          Container(
            height: size.height * 0.75,
            child: dataController.collections.isEmpty?
            StreamBuilder(
              stream: apiClient.getMenu().asStream(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  if(snapshot.data.status){
                    List items = snapshot.data.data;
                    items.forEach((element) {
                      dataController.collections.value[element.id] = element;
                    });
                    return _generateListTiles(dataController);
                  }
                }
                return ListView(
                  children: [logout()],
                );
              },
            ):
            _generateListTiles(dataController)
          )
        ],
      ),
    );
  }

  ListView _generateListTiles(DataController dataController){
    Map collections = dataController.collections;
    List<Widget> listTiles = [];
    collections.forEach((key, value){
      listTiles.add(
        ListTile(
          title: Text(value.name),
          onTap: (){
            dataController.menu.value = key;
            Get.toNamed("/view/?id=${key}");
          },
        ));
    });
    listTiles.add(Divider());
    listTiles.add(
      logout()
    );
    return ListView(
      children: listTiles,
    );
  }

  Widget logout(){
    AppPref pref = AppPref();
    DataController dataController = Get.put(DataController());
    return ListTile(
      title: Text("Salir"),
      onTap: (){
        pref.rutaPage = "/";
        dataController.collections.value = {};
        dataController.menu.value = "";
        Get.toNamed("/");
      },
    );
  }

}
