import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remoteraspy/share_prefs/app_pref.dart';
import 'package:remoteraspy/widgets/drawer_custom.dart';
import 'package:remoteraspy/api/client_api.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int xPoint = 0;
  int yPoint = 0;

  @override
  Widget build(BuildContext context) {
    int widthRemote = 1280;
    int heightRemote = 720;
    Size size = Get.size;
    AppPref pref = AppPref();
    ApiClient api = ApiClient();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await api.scroll('up', 2);
          }, icon: Icon(Icons.chevron_left)),
          IconButton(onPressed: ()async{
            await api.scroll('down', 2);
          }, icon: Icon(Icons.chevron_right)),
          IconButton(onPressed: ()async{
            await api.doubleClick();
          }, icon: Icon(Icons.ads_click)),
          IconButton(onPressed: ()async{
            await api.click();
          }, icon: Icon(Icons.adjust_sharp)),
          IconButton(onPressed: ()async{
            await api.getImageName();
            setState(() {
            });
          }, icon: Icon(Icons.update)),
        ],
      ),
      drawer: DrawerCustom(),
      body: Container(
        color: Colors.black,
        width: size.width,
        height: size.height,
        child: GestureDetector(
          onTapDown: (position){
            final tapPosition = position.globalPosition;
            double x = tapPosition.dx;
            double y = size.height - tapPosition.dy;
            double xMax = size.height - 130;
            double yMax = size.width;
            double xr = y;
            double yr = x;
            xPoint = (tapPosition.dy - 90).toInt();
            yPoint = tapPosition.dx.toInt();
            xr = ((xr - 30) / xMax) * widthRemote;
            yr = (yr / yMax) * heightRemote;
            api.setPoint(xr.toInt() - 10, yr.toInt());
            setState(() {

            });
          },
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Image.network(
                  '${pref.url}/static/${pref.image}',
                ),
                Positioned(
                  top: xPoint.toDouble() - 2,
                  left: yPoint.toDouble() - 2,
                  child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ))
              ],
            ),
          )
        )
      ),
    );
  }
}
