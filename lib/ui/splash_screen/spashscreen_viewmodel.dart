

import '../../model/general_response.dart';
import '../../repository/api_repository.dart';

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

