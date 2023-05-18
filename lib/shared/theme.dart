part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = const Color(0xFF503E9D);
Color primaryAccentColor = const Color(0xFF2C1F63);
Color secondaryAccentColor = const Color(0xFFFBD460);
Color thirdAccentColor = const Color(0xFFADADAD);

TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: thirdAccentColor, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    GoogleFonts.openSans().copyWith(color: secondaryAccentColor);
