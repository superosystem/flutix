part of '../pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData.from(
            colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.yellow,
        ))));
    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(GoToSplashPage());

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 70,
                    child: Image.asset("assets/logo.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 70, bottom: 40),
                    child: Text(
                      "Welcome Back,\nExplorer",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Address"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Text(
                        "Forgot Password?",
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Get Now",
                        style: purpleTextFont.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              backgroundColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : const Color(0xFFE4E4E4),
                              onPressed: isEmailValid && isPasswordValid
                                  ? () async {
                                      setState(() {
                                        isSigningIn = true;
                                      });

                                      SignInSignUpResult result =
                                          await AuthService.signIn(
                                              emailController.text,
                                              passwordController.text);

                                      if (result.user == null) {
                                        setState(() {
                                          isSigningIn = false;
                                        });

                                        Flushbar(
                                          duration: const Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor:
                                              const Color(0xFFFF5C83),
                                          message: result.message,
                                        ).show(context);
                                      }
                                    }
                                  : null,
                              child: Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : const Color(0xFFBEBEBE),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Start Fresh Now?",
                        style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          context.read<PageBloc>().add(GoToSignInPage());
                        },
                        child: Text(
                          "Sign Up",
                          style: purpleTextFont,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
