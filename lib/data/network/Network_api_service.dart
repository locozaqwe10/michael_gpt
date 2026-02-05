import 'dart:convert';
import 'dart:io';

import '/data/app_exceptions.dart';
import '/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getGetResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      print(response.toString());
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, Map<String, String> data) async {
    // TODO: implement getPostApiResponse
    dynamic responseJson;
    try {
      Response response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {"Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded"},
      ).timeout(Duration(seconds: 10));
      print(response.body.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      default:
        throw FetchDataException('Error accorded while communicating with server' + 'with status code ' + response.statusCode.toString());
    }
  }

  @override
  Future getPostApiResponseWithoutParam(String url) async {
    dynamic responseJson;
    try {
      Response response = await http.post(
        Uri.parse(url),

        headers: {"Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded"},
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponseRaw(String url, dynamic data) async {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    var bodyData = encoder.convert(data);
    print(bodyData);
    dynamic responseJson;
    try {
      Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
        headers: {"Accept": "application/json", "Content-Type": "application/json"},
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

}
