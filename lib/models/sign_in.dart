class SignInModel {
  String email;
  String password;

  SignInModel({
    required this.email,
    required this.password,
  });

  // Convert from Json
  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        email: json["email"],
        password: json["password"],
      );

  // Convert to Json
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
