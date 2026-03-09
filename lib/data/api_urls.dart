import 'package:hive/hive.dart';

class ApiUrls {

   //static  String BASE_URL = "http://38.23.33.29:8002/";
   static  String BASE_URL = "http://10.0.2.2:8000/";
   static  String CREATE_USER = "${ApiUrls.BASE_URL}auth/";
   static String LOGIN_USER = "${ApiUrls.BASE_URL}auth/token";
   static String ADD_LLM_MESSAGE = "${ApiUrls.BASE_URL}messages/add_message";
   static String ADD_CHAT_SESSION = "${ApiUrls.BASE_URL}chats/add_session/?user_id=";
   static String CHAT_HISTORY = "${ApiUrls.BASE_URL}chats/getall/";
   static String USER_SUBSCRIPTION = "${ApiUrls.BASE_URL}subscriptions/user/";
   static String UPGRADE_SUBSCRIPTION = "${ApiUrls.BASE_URL}payment/process_payment";
   static String CREATE_PAYMENT_INTENT = "${ApiUrls.BASE_URL}payment/create-payment-intent?amount=";

}