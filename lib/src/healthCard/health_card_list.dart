// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:awesome_card/awesome_card.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Health Card List
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class HealthCardPage extends StatefulWidget {
  const HealthCardPage({Key? key}) : super(key: key);

  @override
  _HealthCardPageState createState() => _HealthCardPageState();
}

class _HealthCardPageState extends State<HealthCardPage> {
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  * Health Card Data
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  List<String> cardNumbers = [];
  List<String> holderInfo = [];
  List<String> cardHolder = [];
  List<String> cvv = [];
  List<bool> showBack = [];

  @override
  void initState() {
    super.initState();

    cardNumbers = [
      'xxxx xxxx 0002',
      'xxxx xxxx 0003',
      'xxxx xxxx 0009',
      'xxxx xxxx 0015',
    ];

    holderInfo = [
      'A+ | High BP',
      'B+ | Allergic to X',
      'AB+ | Allergic to Y',
      'AB+ | Anemic',
    ];

    cardHolder = [
      'Abhijit Sahoo',
      'Abhishek Choudhary',
      'Amogh Mishra',
      'Dhruv Kanthaliya',
    ];
    cvv = [
      '0002',
      '0003',
      '0009',
      '0015',
    ];

    // * For animating front and back of card
    final List<bool> showBackInit =
        List<bool>.filled(cardNumbers.length, false, growable: true);

    showBack = showBackInit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHealthCardList());
  }

  ListView _buildHealthCardList() {
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * Health card generator + divider (.separated)
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: cardNumbers.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          //  * Rebuild card on tap -> animate
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          onTap: () {
            setState(() {
              showBack[index] = !showBack[index];
            });
          },
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          //  * Core health card
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          child: CreditCard(
            cardNumber: cardNumbers[index],
            cardExpiry: holderInfo[index],
            cardHolderName: cardHolder[index],
            cvv: cvv[index],
            bankName: 'Universal Health Card',
            cardType: CardType.other,
            showBackSide: showBack[index],
            frontBackground: CardBackgrounds.black,
            backBackground: CardBackgrounds.white,
            showShadow: true,
            textExpDate: 'Holder Info',
            textName: 'Name',
            textExpiry: 'Health Info',
            height: MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width
                ? MediaQuery.of(context).size.height * 0.3
                : MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.height >
                    MediaQuery.of(context).size.width
                ? MediaQuery.of(context).size.width * 0.9
                : MediaQuery.of(context).size.width * 0.6,
          ),
        );
      },
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      //  * Separator
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      separatorBuilder: (context, index) {
        return const SizedBox(height: 32);
      },
    );
  }
}
