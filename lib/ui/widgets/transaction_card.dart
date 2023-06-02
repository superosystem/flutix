part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final FlutixTransaction? transaction;
  final double width;

  const TransactionCard(this.transaction, this.width, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        height: 90,
        width: 70,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: (transaction?.picture != null)
                    ? NetworkImage('${imageBaseURL}w500${transaction!.picture}')
                    : const AssetImage('assets/bg_topup.png') as ImageProvider,
                fit: BoxFit.cover)),
      ),
      Column(
        children: <Widget>[
          SizedBox(
              width: width - 86,
              child: Text(transaction!.title,
                  style: blackTextFont.copyWith(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.clip)),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
              width: width - 86,
              child: Text(
                  NumberFormat.currency(locale: 'id', symbol: 'Rp').format(
                      transaction!.amount < 0
                          ? -transaction!.amount
                          : transaction!.amount),
                  style: whiteNumberFont.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: transaction!.amount < 0
                          ? const Color(0xFFFF5C83)
                          : const Color(0xFF3E9D9D)))),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
              width: width - 86,
              child: Text(
                transaction!.subtitle,
                style: greyTextFont.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w400),
              )),
        ],
      )
    ]);
  }
}
