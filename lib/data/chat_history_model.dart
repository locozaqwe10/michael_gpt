import 'dart:convert';

class ChatHisotryModel {
  final String? title;
  final int? id;
  final String? userId;
  final DateTime? createdAt;
  final List<Message> messages;

  ChatHisotryModel({
    this.title,
    this.id,
    this.userId,
    this.createdAt,
    required this.messages,
  });

  factory ChatHisotryModel.fromJson(Map<String, dynamic> json) {
    return ChatHisotryModel(
      title: json['title'],
      id: json['id'],
      userId: json['user_id'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      messages: json['messages'] != null
          ? (json['messages'] as List)
          .map((e) => Message.fromJson(e))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "messages": messages.map((e) => e.toJson()).toList(),
  };
}

class Message {
  final String? content;
  final int? id;
  final int? contentCount;
  final int? chatSessionId;
  final String? role;
  final DateTime? createdAt;
  final int? tokenDims;

  Message({
    this.content,
    this.id,
    this.contentCount,
    this.chatSessionId,
    this.role,
    this.createdAt,
    this.tokenDims,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      id: json['id'],
      contentCount: json['content_count'],
      chatSessionId: json['chat_session_id'],
      role: json['role'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      tokenDims: json['token_dims'],
    );
  }

  Map<String, dynamic> toJson() => {
    "content": content,
    "id": id,
    "content_count": contentCount,
    "chat_session_id": chatSessionId,
    "role": role,
    "created_at": createdAt?.toIso8601String(),
    "token_dims": tokenDims,
  };

  /// 🔥 Extract AI Output if content contains JSON string
  String get parsedContent {
    if (content == null) return "";

    try {
      final decoded = jsonDecode(content!);
      if (decoded is Map && decoded.containsKey("output")) {
        return decoded["output"];
      }
    } catch (_) {}

    return content!;
  }

  bool get isUser => role == "u";
  bool get isAssistant => role == "a";
}