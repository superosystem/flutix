part of 'models.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguage;
  final int? balance;

  const UserModel(
    this.id,
    this.email, {
    required this.name,
    required this.profilePicture,
    required this.selectedGenres,
    required this.selectedLanguage,
    required this.balance,
  });

  UserModel copyWith({String? name, String? profilePicture, int? balance}) =>
      UserModel(id, email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          balance: balance ?? this.balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  // Convert User Model from Json Response
  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //       id: json['uid'],
  //       email: json['email'],
  //       name: json['name'],
  //       profilePicture: json['profilePicture'],
  //       selectedGenres:
  //           (json['selectedGenres'] as List).map((e) => e.toString()).toList(),
  //       selectedLanguage: json['selectedLanguage'],
  //       balance: json['balance'],
  //     );

  // Convert to JSON
  Map<String, dynamic> toJson() => {
        'uid': id,
        'email': email,
        'name': name,
        'profilePicture': profilePicture,
        'selectedGenres': selectedGenres,
        'selectedLanguage': selectedLanguage,
        'balance': balance,
      };

  // Override 'toString' method to generate user as constant string
  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  // Passing property model to list object
  @override
  List<Object?> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedLanguage,
        balance
      ];
}
