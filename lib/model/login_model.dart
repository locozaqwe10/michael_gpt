class LoginModel {
    String userEmail;
    String userId;
    String userName;
    Token token;

    LoginModel({
        required this.userEmail,
        required this.userId,
        required this.userName,
        required this.token,
    });

    LoginModel copyWith({
        String? userEmail,
        String? userId,
        String? userName,
        Token? token,
    }) =>
        LoginModel(
            userEmail: userEmail ?? this.userEmail,
            userId: userId ?? this.userId,
            userName: userName ?? this.userName,
            token: token ?? this.token,
        );
}

class Token {
    String accessToken;
    String tokenType;

    Token({
        required this.accessToken,
        required this.tokenType,
    });

    Token copyWith({
        String? accessToken,
        String? tokenType,
    }) =>
        Token(
            accessToken: accessToken ?? this.accessToken,
            tokenType: tokenType ?? this.tokenType,
        );
}
