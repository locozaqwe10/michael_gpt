import 'package:custom_chat_gpt/model/general_response.dart';
import 'package:custom_chat_gpt/repository/api_repository.dart';

class SplashScreenViewmodel {
var _repo = ApiRepository();

   Future<GeneralResponse> getAPIkey (String keyName) async{
   var response = await  _repo.getKeybyName(keyName);
   return response;

   }

Future<GeneralResponse> getAPIallkey () async{
  var response = await  _repo.getKeysAll();
  return response;

}
}

