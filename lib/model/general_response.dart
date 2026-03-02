class GeneralResponse {

  String message;
  String user;
  int code;
  dynamic data;

  GeneralResponse({
  required this.message,
  required this.user,
  required this.code,
  required this.data,
  });

  GeneralResponse copyWith({
  String? message,
  String? user,
  int? code,
  dynamic? data,
  }) =>
      GeneralResponse(
  message: message ?? this.message,
  user: user ?? this.user,
  code: code ?? this.code,
  data: data ?? this.data,
  );





}