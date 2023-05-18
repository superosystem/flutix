part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get User from Firebase Auth
    User? firebaseUser = Provider.of<User?>(context);

    if (firebaseUser == null) {
      if (prevPageEvent is! GoToSplashPage) {
        prevPageEvent = GoToSplashPage();
        context.read<PageBloc>().add(prevPageEvent!);
      }
    } else {
      if (prevPageEvent is! GoToMainPage) {
        context.read<UserBloc>().add(LoadUser(firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.read<PageBloc>().add(prevPageEvent!);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) => (pageState is OnSplashPage)
          ? const SplashPage()
          : (pageState is OnSignInPage)
              ? const SignInPage()
              : (pageState is OnSignUpPage)
                  ? SignUpPage(pageState.signUpData)
                  : (pageState is OnSignUpPreferencePage)
                      ? SignUpPreferencePage(pageState.signUpData)
                      : (pageState is OnSignUpAccountConfirmationPage)
                          ? SignUpAccountConfirmationPage(pageState.signUpData)
                          : const MainPage(),
    );
  }
}
