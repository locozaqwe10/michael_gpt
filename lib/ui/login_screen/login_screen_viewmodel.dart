import '../../model/general_response.dart';
import '../../repository/api_repository.dart';
import 'package:flutter/cupertino.dart';

class LoginScreenViewmodel extends ChangeNotifier{

  var Repository = ApiRepository();

  Future<GeneralResponse> UserLogin(dynamic data) async {
    var response =   await Repository.postUserLogin(data);

    return response;
  }




}