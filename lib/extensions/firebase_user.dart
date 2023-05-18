part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserModel convertToUserModel(
          {String name = "No Name",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 50000}) =>
      UserModel(uid, email!,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage,
          profilePicture: '');

  Future<UserModel> fromFireStore() async => await UserService.getUser(uid);
}
