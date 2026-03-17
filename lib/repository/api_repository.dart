import 'dart:convert';


import 'package:http/http.dart';

import '../data/api_urls.dart';
import '../data/network/Network_api_service.dart';
import '../data/network/base_api_services.dart';
import '../model/general_response.dart';
import '../model/payment_model.dart';

class ApiRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> postCreateUser(dynamic datamap) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponse(
        ApiUrls.CREATE_USER,
        datamap,
      );

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
        response.body.toString();
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }

  Future<GeneralResponse> postUserLogin(dynamic datamap) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponse(
        ApiUrls.LOGIN_USER,
        datamap,
      );

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
        response.body.toString();
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString()+"  Repo 0x00001");
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }

  Future<GeneralResponse> postAddLLMmessage(dynamic datamap) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponse(
        ApiUrls.ADD_LLM_MESSAGE,
        datamap,
      );

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
        response.body.toString();
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }

  Future<GeneralResponse> postAddSessionID(String userId) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponseWithoutParam(
        ApiUrls.ADD_CHAT_SESSION+userId,

      );

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
        response.body.toString();
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }


  Future<GeneralResponse> getChatHisotry(String userId) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponseWithoutParam(
        ApiUrls.CHAT_HISTORY+userId,

      );

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"][0],
        );
        response.body.toString();
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }

  Future<GeneralResponse> getUserSubscription (String userId) async {
    Response response;
    try {
      response = await _apiService.getGetResponse(
        ApiUrls.USER_SUBSCRIPTION+userId,

      );

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"][0],
        );
        response.body.toString();
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }

  }


  Future<GeneralResponse> postUpgradeSubscription(PaymentModel payment) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponse(
        ApiUrls.UPGRADE_SUBSCRIPTION,payment.toJson() as Map<String, String>

      );

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["payment"],
        );
        response.body.toString();
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }


  Future<GeneralResponse> postgetKeyFromAPI(int amount) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponseWithoutParam(
          ApiUrls.CREATE_PAYMENT_INTENT+ amount.toString());

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }

  Future<GeneralResponse> postUpdateProfile(Map<String, String> data) async {
    Response response;
    try {
      response = await _apiService.getPostApiResponse(
          ApiUrls.UPDATE_PROFILE, data);

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );


    }
  }


  Future<GeneralResponse> getProfileData(String UUID) async {
    Response response;
    try {
      response = await _apiService.getGetResponse(
          ApiUrls.GET_USER+ UUID);

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }

  Future<GeneralResponse> getKeysAll() async {
    Response response;
    try {
      response = await _apiService.getGetResponse(
          ApiUrls.GET_KEYS_ALL);

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }

  Future<GeneralResponse> getKeybyName(String keyName) async {
    Response response;
    try {
      response = await _apiService.getGetResponse(
          ApiUrls.GET_KEY_BY_NAME+keyName);

      var jsonResponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        return GeneralResponse(
          message: jsonResponse["message"],
          user: "",
          code: response.statusCode,
          data: jsonResponse["data"],
        );
      } else {
        return GeneralResponse(
          message: jsonResponse["detail"],
          user: "",
          code: response.statusCode,
          data: {},
        );
      }
    } catch (e) {
      print(e.toString());
      return GeneralResponse(
        message: e.toString(),
        user: "",
        code: 500,
        data: {},
      );

      rethrow;
    }
  }
}
