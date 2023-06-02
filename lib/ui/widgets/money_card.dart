part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function? onTap;

  const MoneyCard(
      {Key? key,
      this.isSelected = false,
      this.amount = 0,
      required this.onTap,
      this.width = 90})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color:
                    isSelected ? Colors.transparent : const Color(0xFFE4E4E4)),
            color: isSelected ? accentColor2 : Colors.transparent),
        child: Column(
          children: <Widget>[
            Text(
              "IDR",
              style: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', decimalDigits: 0, symbol: '')
                  .format(amount),
              style: whiteNumberFont.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
