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
  HealthCardPage({Key key}) : super(key: key);

  @override
  _HealthCardPageState createState() => _HealthCardPageState();
}

class _HealthCardPageState extends State<HealthCardPage> {
  final _getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          title: Text('Health Cards'),
        ),
        body: _buildHealthCardList());
  }

  ListView _buildHealthCardList() {
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * Health Card Data
    //  TODO: implement firebase
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    List<String> cardNumbers = [
      'xxxx xxxx 0002',
      'xxxx xxxx 0003',
      'xxxx xxxx 0009',
      'xxxx xxxx 0015',
    ];
    List<String> holderInfo = [
      'A+ | High BP',
      'B+ | Allergic to X',
      'AB+ | Allergic to Y',
      'AB+ | Anemic',
    ];
    List<String> cardHolder = [
      'Abhijit Sahoo',
      'Abhishek Choudhary',
      'Amogh Mishra',
      'Dhruv Kanthaliya',
    ];
    List<String> cvv = [
      '0002',
      '0003',
      '0009',
      '0015',
    ];
    // * For animating front and back of card
    initShowBack();
    List showBack = _getStorage.read('cardOrientation').length ==
            cardNumbers.length // if equal
        ? _getStorage.read('cardOrientation') // then use saved state
        : List<bool>.filled(cardNumbers.length, false,
            growable: true); // else, create a new bool list

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * Health card generator + divider (.separated)
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      itemCount: cardNumbers.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          //  * Rebuild card on tap -> animate
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          onTap: () {
            showBack[index] = !showBack[index];
            _getStorage.write('cardOrientation', showBack);
            setState(() {});
          },
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          //  * Core health card
          // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
          child: CreditCard(
            cardNumber: '${cardNumbers[index]}',
            cardExpiry: '${holderInfo[index]}',
            cardHolderName: '${cardHolder[index]}',
            cvv: '${cvv[index]}',
            bankName: 'Universal Health Card',
            cardType: CardType.other,
            showBackSide: showBack[index],
            frontBackground: CardBackgrounds.black,
            backBackground: CardBackgrounds.white,
            showShadow: true,
            textExpDate: 'Holder Info',
            textName: 'Name',
            textExpiry: 'Health Info',
          ),
        );
      },
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      //  * Separator
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      separatorBuilder: (context, index) {
        return Divider(
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
