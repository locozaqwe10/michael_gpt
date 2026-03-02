import 'package:hive/hive.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 1)
class UserHiveModel extends HiveObject {

  @HiveField(0)
  String userId;

  @HiveField(1)
  String email;

  @HiveField(2)
  String userName;

  @HiveField(3)
  int subscriptionId;

  @HiveField(4)
  int subscriptionInTokenAllowed;

  @HiveField(5)
  int subscriptionOutTokenAllowed;

  @HiveField(6)
  int userInToken;

  @HiveField(7)
  int userOutToken;

  @HiveField(8)
  String? token ;

  @HiveField(9)
  String subscriptionFriendlyName;

  UserHiveModel({
    required this.userId,
    required this.email,
    required this.userName,
    required this.subscriptionId,
    required this.subscriptionInTokenAllowed,
    required this.subscriptionOutTokenAllowed,
    required this.userInToken,
    required this.userOutToken,
    required this.token ,
    required this.subscriptionFriendlyName,
  });

  // ==========================
  // Getters
  // ==========================

  String get getUserId => userId;
  String get getEmail => email;
  String get getUserName => userName;
  int get getSubscriptionId => subscriptionId;
  int get getSubscriptionInTokenAllowed => subscriptionInTokenAllowed;
  int get getSubscriptionOutTokenAllowed => subscriptionOutTokenAllowed;
  int get getUserInToken => userInToken;
  int get getUserOutToken => userOutToken;
  String? get gettoken => token ?? "";
  String get getSubscriptionFriendlyName =>subscriptionFriendlyName;

  // ==========================
  // Setters (auto-save)
  // ==========================

  Future<void> setUserId(String value) async {
    userId = value;
    await save();
  }

  Future<void> setEmail(String value) async {
    email = value;
    await save();
  }

  Future<void> setUserName(String value) async {
    userName = value;
    await save();
  }

  Future<void> setSubscriptionId(int value) async {
    subscriptionId = value;
    await save();
  }

  Future<void> setSubscriptionInTokenAllowed(int value) async {
    subscriptionInTokenAllowed = value;
    await save();
  }

  Future<void> setSubscriptionOutTokenAllowed(int value) async {
    subscriptionOutTokenAllowed = value;
    await save();
  }

  Future<void> setUserInToken(int value) async {
    userInToken = value;
    await save();
  }

  Future<void> setUserOutToken(int value) async {
    userOutToken = value;
    await save();
  }

  Future<void> settoken(String value) async {
    token = value;
    await save();
  }

  Future<void> setSubscriptionFriendlyName (String value) async {
    subscriptionFriendlyName = value;
    await save();
  }
}