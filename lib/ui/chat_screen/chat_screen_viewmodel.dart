import 'package:custom_chat_gpt/repository/api_repository.dart';

import '../../model/general_response.dart';

class ChatScreenViewmodel {
  var _repo = ApiRepository();

  Future<GeneralResponse> sendLLMmessage(dynamic datamap) async {

return await _repo.postAddLLMmessage(datamap);

  }
  Future<GeneralResponse> addSessionID(String userId) async {

    return await _repo.postAddSessionID(userId);

  }

}