import 'package:custom_chat_gpt/model/general_response.dart';
import 'package:custom_chat_gpt/repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../data/network/Network_api_service.dart';
import '../../data/network/base_api_services.dart';
import '../../utilities/utils.dart';

class CreateAccountViewmodel extends ChangeNotifier{


  final _myRepo = ApiRepository();

    Future<GeneralResponse> createUser (dynamic data) async {

              var response =   await _myRepo.postCreateUser(data);

              return response;
    }

}