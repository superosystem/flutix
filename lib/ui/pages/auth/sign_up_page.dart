part of '../pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  const SignUpPage(this.registrationData, {Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context.read<ThemeBloc>().add(ChangeTheme(ThemeData.from(
            colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
        ))));
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());

        return true;
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
                    margin: const EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToSplashPage());
                            },
                            child: const Icon(Icons.arrow_back,
                                color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Create New\nAccount",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (widget
                                              .registrationData.profileImage ==
                                          null)
                                      ? const AssetImage("assets/user_pic.png")
                                      : FileImage(widget.registrationData
                                          .profileImage!) as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profileImage ==
                                  null) {
                                widget.registrationData.profileImage =
                                    await ambilImage();
                              } else {
                                widget.registrationData.profileImage = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage((widget.registrationData
                                                  .profileImage ==
                                              null)
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png"))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Full Name",
                        hintText: "Full Name"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Email",
                        hintText: "Email"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: retypePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Confirm Password",
                        hintText: "Confirm Password"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                      backgroundColor: mainColor,
                      elevation: 0,
                      onPressed: () {
                        if (!(nameController.text.trim() != "" &&
                            emailController.text.trim() != "" &&
                            passwordController.text.trim() != "" &&
                            retypePasswordController.text.trim() != "")) {
                          Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: const Color(0xFFFF5C83),
                            message: "Please fill all the fields",
                          ).show(context);
                        } else if (passwordController.text !=
                            retypePasswordController.text) {
                          Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: const Color(0xFFFF3C83),
                            message: "Mismatch password and confirmed password",
                          ).show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: const Color(0xFFFF5C83),
                            message: "Password's length min 6 characters",
                          ).show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Flushbar(
                            duration: const Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: const Color(0xFFFF5C83),
                            message: "Wrong formatted email address",
                          ).show(context);
                        } else {
                          widget.registrationData.name = nameController.text;
                          widget.registrationData.email = emailController.text;
                          widget.registrationData.password =
                              passwordController.text;
                          context
                              .read<PageBloc>()
                              .add(GoToPreferencePage(widget.registrationData));
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
