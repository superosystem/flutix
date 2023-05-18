part of 'services.dart';

class UserService {
  // Instancing fire store user collection
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  // Method to saving updated user data to fire store
  static Future<void> updateUser(UserModel user) async {
    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture,
      'balance': user.balance
    });
  }

  // Method to getting user data from fire store
  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();
    // Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;

    return UserModel(
      id,
      (snapshot.data() as dynamic)['email'],
      balance: (snapshot.data() as dynamic)['balance'],
      profilePicture: (snapshot.data() as dynamic)['profilePicture'],
      selectedGenres: ((snapshot.data() as dynamic)['selectedGenres'] as List)
          .map((e) => e.toString())
          .toList(),
      selectedLanguage: (snapshot.data() as dynamic)['selectedLanguage'],
      name: (snapshot.data() as dynamic)['name'],
    );
  }
}
