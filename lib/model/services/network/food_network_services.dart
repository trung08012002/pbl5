import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer' as devtool;

String baseurl = '';

class FoodNetworkServices {
  final dio = Dio();
  Future getResponse(String url, Map<String, dynamic>? para) async {
    try {
      final response = await dio.get(
        baseurl + url,
        queryParameters: para,
      );
      return jsonDecode(response.data) as Map<String, dynamic>;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        devtool.log(e.response!.data);
        devtool.log(e.response!.headers.toString());
        devtool.log(e.response!.requestOptions.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        devtool.log(e.requestOptions.toString());
        devtool.log(e.message.toString());
      }
    }
  }

  Future postrequest(String url, Map<String, dynamic> data) async {
    dio.post(baseurl + url, data: data);
  }
}
