part of 'services.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method Sign Up
  static Future<SignInSignUpResult> signUp(String email, String password,
      String name, List<String> selectedGenres, String selectedLanguage) async {
    try {
      // Create user account
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update User
      UserModel user = result.user!.convertToUserModel(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UserService.updateUser(user);

      // DEBUG ON CONSOLE
      if (kDebugMode) {
        print(user);
      }

      return SignInSignUpResult(user: user);
    } catch (e) {
      // DEBUG ON CONSOLE
      if (kDebugMode) {
        print(e.toString());
      }
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  // Method Sign In
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = await UserService.getUser(result.user!.uid);

      // DEBUG ON CONSOLE
      if (kDebugMode) {
        print(user);
      }

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  // Method Sign Out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  ///Receive [FirebaseUser] each time the user signIn or signOut
  ///For information about when have a status changed in Firebase Authentication like a
  ///Sign in up out
  static Stream<User?> get userStream => _auth.authStateChanges();

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
