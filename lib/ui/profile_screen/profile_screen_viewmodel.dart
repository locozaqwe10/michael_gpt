
import 'package:flutter/cupertino.dart';

import '../../model/general_response.dart';
import '../../repository/api_repository.dart';

class ProfileViewModel{

ApiRepository _repo = ApiRepository();

  Future<GeneralResponse>? getProfile(String  userID) async {
    var response =  await  _repo.getProfileData(userID);
    return response;
  }

 Future<GeneralResponse>? updateProfile(Map<String, String> data) async {
   var response =  await  _repo.postUpdateProfile(data);
   return response;
}

}