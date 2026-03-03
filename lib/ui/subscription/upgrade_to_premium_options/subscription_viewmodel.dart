import 'package:customchatgpt/model/general_response.dart';
import 'package:customchatgpt/model/payment_model.dart';
import 'package:customchatgpt/repository/api_repository.dart';

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