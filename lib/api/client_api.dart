import 'package:dio/dio.dart';
import 'package:remoteraspy/share_prefs/app_pref.dart';


class ApiClient{

  final String GET = "GET";
  final String POST = "POST";
  final String PUT = "PUT";
  final String DELETE = "DELETE";
  final Dio _dio = Dio();

  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();
  AppPref pref = AppPref();

  Future<CustomResponse> validationRequest({
    required String typeRequest,
    required String url,
    Map body = const {},
    Map<String, String> headers = const {},
    FormData? data
  }) async {
    try{
      late Response response;
      if(typeRequest == GET){
        response = await _dio.get(
          url,
          options: Options(
            headers: headers,
          )
        );
      }else if(typeRequest == POST){
        response = await _dio.post(
          url,
          data: data==null?body:data,
          options: Options(
            headers: headers,
          )
        );
      }else if(typeRequest == PUT){
        response = await _dio.put(
          url,
          data: data==null?body:data,
          options: Options(
            headers: headers,
          )
        );
      }else if(typeRequest == DELETE){
        response = await _dio.delete(
          url,
          options: Options(
            headers: headers,
          )
        );
      }
      if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204){
        return CustomResponse(true, response.data);
      }
      return CustomResponse(false, {});
    }on DioError catch (e) {
      return CustomResponse(false, e);
    }
  }

  Future<CustomResponse> getSize(String url) async {
    CustomResponse response = await validationRequest(
      typeRequest: GET,
      url: '$url/',
    );
    return response;
  }

  Future<CustomResponse> getMenu() async {
    return CustomResponse(false, {});
  }

  Future<CustomResponse> getImageName() async {
    String url = '${pref.url}/screenshot/';
    CustomResponse response = await validationRequest(
      typeRequest: GET,
      url: url,
    );
    pref.image = response.data['file_name'];
    return response;
  }

  Future<CustomResponse> setPoint(int width, int height) async {
    String url = '${pref.url}/set_point/$width/$height/';
    CustomResponse response = await validationRequest(
      typeRequest: GET,
      url: url,
    );
    return response;
  }

  Future<CustomResponse> click() async {
    String url = '${pref.url}/click';
    CustomResponse response = await validationRequest(
      typeRequest: GET,
      url: url,
    );
    return response;
  }

  Future<CustomResponse> doubleClick() async {
    String url = '${pref.url}/double_click';
    CustomResponse response = await validationRequest(
      typeRequest: GET,
      url: url,
    );
    return response;
  }

  Future<CustomResponse> scroll(String type, int size) async {
    String url = '${pref.url}/scroll/$type/$size/';
    CustomResponse response = await validationRequest(
      typeRequest: GET,
      url: url,
    );
    return response;
  }

}

class CustomResponse{
  final _data;
  final bool _status;

  CustomResponse(this._status, this._data);

  get data{
    return _data;
  }
  bool get status{
    return _status;
  }
}
