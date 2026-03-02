class ChatMessage {
  final String message;
  final String isMe;
  final DateTime time;
  final bool isLoading;
  final String? errorMessage;

  ChatMessage({
    required this.message,
    required this.isMe,
    required this.time,
    this.isLoading = false,
    required this.errorMessage
  });
}