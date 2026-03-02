import 'package:custom_chat_gpt/model/general_response.dart';
import 'package:custom_chat_gpt/model/payment_model.dart';
import 'package:custom_chat_gpt/repository/api_repository.dart';

class SubscriptionViewmodel {

  var _rep = ApiRepository();

  Future<GeneralResponse> upgradeSubscription(PaymentModel payment) async {

    var response =  await  _rep.postUpgradeSubscription(payment);
    return response;


  }

  Future<GeneralResponse> getSubscription(String user_id) async {
return  await _rep.getUserSubscription(user_id);

  }

  Future<GeneralResponse> getKeyFromAPI(int amount) async {

    return await _rep.postgetKeyFromAPI(amount);

  }
}