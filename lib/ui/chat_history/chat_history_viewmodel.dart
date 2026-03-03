import '../../data/chat_history_model.dart';
import '../../repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../data/response/api_response.dart';

class ChatHistoryViewmodel extends ChangeNotifier{


  var _repo = ApiRepository();
  ApiResponse< List<ChatHisotryModel> > apiChatHistoryNotify = ApiResponse.loading();

  notiferChatHistory(ApiResponse< List<ChatHisotryModel> > response) {
    apiChatHistoryNotify = response;
    notifyListeners();
  }

  Future<void> getChatHistory(String userId)async {

    notiferChatHistory(ApiResponse.loading());

    var response = await _repo.getChatHisotry(userId);
    if (response.code == 200){

      if (kDebugMode)
      print(response.data);

      final List<ChatHisotryModel> chatHistory =
      (response.data as List)
          .map((e) => ChatHisotryModel.fromJson(e))
          .toList();

      notiferChatHistory(ApiResponse.completed(chatHistory));

    }else {
      notiferChatHistory(ApiResponse.error(response.message));
    }

  }
}