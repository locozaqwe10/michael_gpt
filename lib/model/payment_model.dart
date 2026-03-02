import 'dart:convert';

class PaymentModel {
  final int paymentType;
  final int amount;
  final String transactionId;
  final DateTime transCreatedAt;
  final int transStatus;
  final int subscriptionId;
  final String userId;

  PaymentModel({
    required this.paymentType,
    required this.amount,
    required this.transactionId,
    required this.transCreatedAt,
    required this.transStatus,
    required this.subscriptionId,
    required this.userId,
  });

  // From JSON
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentType: json['payment_type'] as int,
      amount: (json['amount'] as num).toInt(), // ensures double type
      transactionId: json['transaction_id'] as String,
      transCreatedAt: DateTime.parse(json['trans_createdat'] as String),
      transStatus: json['trans_status'] as int,
      subscriptionId: json['subscription_id'] as int,
      userId: json['user_id'] as String,
    );
  }

  // To JSON
  Map<String, String> toJson() {
    return {
      'payment_type': "$paymentType",
      'amount': "$amount",
      'transaction_id': transactionId,
      'trans_createdat': transCreatedAt.toIso8601String().toString(),
      'trans_status': "$transStatus",
      'subscription_id': "$subscriptionId",
      'user_id': userId,
    };
  }

  // Optional: From JSON string
  factory PaymentModel.fromRawJson(String str) =>
      PaymentModel.fromJson(json.decode(str));

  // Optional: To JSON string
  String toRawJson() => json.encode(toJson());
}