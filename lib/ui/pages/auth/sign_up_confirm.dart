part of '../pages.dart';

class SignUpAccountConfirmationPage extends StatefulWidget {
  final SignUpModel signUpData;

  const SignUpAccountConfirmationPage(this.signUpData, {Key? key})
      : super(key: key);

  @override
  State<SignUpAccountConfirmationPage> createState() =>
      _SignUpAccountConfirmationPageState();
}

class _SignUpAccountConfirmationPageState
    extends State<SignUpAccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToSignUpPreferencePage(widget.signUpData));

        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 90),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToSplashPage());
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Confirm\n New Account",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: (widget.signUpData.profileImage == null)
                                ? const AssetImage("assets/user_pic.png")
                                : FileImage(widget.signUpData.profileImage!)
                                    as ImageProvider,
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Welcome",
                    style: blackTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    widget.signUpData.name,
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 110),
                  (isSigningUp)
                      ? const SpinKitFadingCircle(
                          color: Color(0xFF3E9D9D),
                          size: 45,
                        )
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3E9D9D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Create My Account",
                              style: whiteTextFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  widget.signUpData.profileImage;

                              SignInSignUpResult result =
                                  await AuthService.signUp(
                                      widget.signUpData.email,
                                      widget.signUpData.password,
                                      widget.signUpData.name,
                                      widget.signUpData.selectedGenres,
                                      widget.signUpData.selectedLanguage);
                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });
                                Flushbar(
                                  duration: const Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: const Color(0xFFFF5C83),
                                  message: result.message,
                                ).show(context);
                              }
                            },
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
