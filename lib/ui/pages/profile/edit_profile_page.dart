part of '../pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserApp user;

  const EditProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late String profilePath;
  bool isDataEdited = false;
  late File? profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        context.read<PageBloc>().add(GoToProfilePage());

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Edit Your\nProfile",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 22, bottom: 10),
                        width: 90,
                        height: 104,
                        child: Stack(
                          children: <Widget>[
                            Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: (profileImageFile != null)
                                            ? FileImage(profileImageFile!)
                                            : (profilePath != "")
                                                ? NetworkImage(profilePath)
                                                : const AssetImage(
                                                        "assets/user_pic.png")
                                                    as ImageProvider,
                                        fit: BoxFit.cover))),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (profilePath == "") {
                                    profileImageFile = await ambilImage();

                                    if (profileImageFile != null) {
                                      profilePath =
                                          basename(profileImageFile!.path);
                                    }
                                  } else {
                                    profileImageFile = null;
                                    profilePath = "";
                                  }

                                  setState(() {
                                    isDataEdited =
                                        (nameController.text.trim() !=
                                                    widget.user.name ||
                                                profilePath !=
                                                    widget.user.profilePicture)
                                            ? true
                                            : false;
                                  });
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage((profilePath == "")
                                              ? "assets/btn_add_photo.png"
                                              : "assets/btn_del_photo.png"))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      AbsorbPointer(
                        child: TextField(
                          controller:
                              TextEditingController(text: widget.user.id),
                          style: whiteNumberFont.copyWith(color: accentColor3),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "User ID",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AbsorbPointer(
                        child: TextField(
                          controller:
                              TextEditingController(text: widget.user.email),
                          style: greyTextFont,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Email Address",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: nameController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (text.trim() != widget.user.name ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false;
                          });
                        },
                        style: blackTextFont,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Full Name",
                            hintText: "Full Name"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 250,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400],
                                disabledForegroundColor:
                                    const Color(0xFFE4E4E4).withOpacity(0.38),
                                disabledBackgroundColor:
                                    const Color(0xFFE4E4E4).withOpacity(0.12),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: (isUpdating)
                                ? null
                                : () async {
                                    await AuthServices.resetPassword(
                                        widget.user.email);

                                    Flushbar(
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: const Color(0xFFFF5C83),
                                      message:
                                          "The link to change your password has been sent to your email.",
                                    ).show(context);
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Change Password",
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: (isUpdating)
                                          ? const Color(0xFFBEBEBE)
                                          : Colors.white),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      (isUpdating)
                          ? const SizedBox(
                              width: 50,
                              height: 50,
                              child: SpinKitFadingCircle(
                                color: Color(0xFF3E9D9D),
                              ),
                            )
                          : SizedBox(
                              width: 250,
                              height: 45,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3E9D9D),
                                      disabledForegroundColor:
                                          const Color(0xFFE4E4E4)
                                              .withOpacity(0.38),
                                      disabledBackgroundColor:
                                          const Color(0xFFE4E4E4)
                                              .withOpacity(0.12),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                                  onPressed: (isDataEdited)
                                      ? () async {
                                          setState(() {
                                            isUpdating = true;
                                          });

                                          if (profileImageFile != null) {
                                            profilePath = await uploadImage(
                                                profileImageFile!);
                                          }

                                          context.read<UserBloc>().add(
                                              UpdateData(
                                                  name: nameController.text,
                                                  profileImage: profilePath));

                                          context
                                              .read<PageBloc>()
                                              .add(GoToProfilePage());
                                        }
                                      : null,
                                  child: Text(
                                    "Update My Profile",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: (isDataEdited)
                                            ? Colors.white
                                            : const Color(0xFFBEBEBE)),
                                  )),
                            )
                    ],
                  )
                ],
              ),
            ),
            SafeArea(
                child: Container(
              margin: const EdgeInsets.only(top: 20, left: defaultMargin),
              child: GestureDetector(
                onTap: () {
                  context.read<PageBloc>().add(GoToProfilePage());
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
