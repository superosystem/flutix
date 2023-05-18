part of 'models.dart';

class SignUpModel {
  String email;
  String name;
  String password;
  List<String> selectedGenres;
  String selectedLanguage;
  File? profileImage;

  SignUpModel({
    this.email = '',
    this.name = '',
    this.password = '',
    this.selectedGenres = const [],
    this.selectedLanguage = '',
    this.profileImage,
  });
}

class SignInSignUpResult {
  UserModel? user;
  String? message;

  SignInSignUpResult({this.user, this.message});
}
