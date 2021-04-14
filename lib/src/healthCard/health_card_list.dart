// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:awesome_card/awesome_card.dart';
import 'package:get_storage/get_storage.dart';

// Flutter Components Imports for Navigation

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Health Card List
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class HealthCardPage extends StatefulWidget {
  const HealthCardPage({Key? key}) : super(key: key);

  @override
  _HealthCardPageState createState() => _HealthCardPageState();
}

class _HealthCardPageState extends State<HealthCardPage> {
  final _getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHealthCardList());
  }

  ListView _buildHealthCardList() {
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * Health Card Data
    //  TODO: implement firebase
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    final List<String> cardNumbers = [
      'xxxx xxxx 0002',
      'xxxx xxxx 0003',
      'xxxx xxxx 0009',
      'xxxx xxxx 0015',
    ];
    final List<String> holderInfo = [
      'A+ | High BP',
      'B+ | Allergic to X',
      'AB+ | Allergic to Y',
      'AB+ | Anemic',
    ];
    final List<String> cardHolder = [
      'Abhijit Sahoo',
      'Abhishek Choudhary',
      'Amogh Mishra',
      'Dhruv Kanthaliya',
    ];
    final List<String> cvv = [
      '0002',
      '0003',
      '0009',
      '0015',
    ];
    // * For animating front and back of card
    initShowBack();
    final List<bool>? showBack = _getStorage.read('cardOrientation').length ==
            cardNumbers.length // if equal
        ? _getStorage.read('cardOrientation') // then use saved state
        : List<bool>.filled(cardNumbers.length, false,
            growable: true); // else, create a new bool list

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
            showBack![index] = !showBack[index];
            _getStorage.write('cardOrientation', showBack);
            setState(() {});
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
            showBackSide: showBack![index],
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
        return const Divider(
          thickness: 2,
          height: 40,
          indent: 20,
          endIndent: 20,
        );
      },
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  * Initialize for first time install -> prevent null error
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  void initShowBack() {
    if (_getStorage.read('cardOrientation') == null) {
      _getStorage.write('cardOrientation', [false]);
    }
  }
}
