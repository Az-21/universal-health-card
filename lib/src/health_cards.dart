// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:awesome_card/awesome_card.dart';
import 'package:get_storage/get_storage.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Health Card UI
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
        toolbarHeight: 100,
        title: Text('Health Cards'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
        child: _buildHealthCardList(),
      ),
    );
  }

  ListView _buildHealthCardList() {
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * Health Card Data
    //  TODO: implement firebase
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    List<String> cardNumbers = [
      'xxxx xxxx xxxx 0002',
      'xxxx xxxx xxxx 0003',
      'xxxx xxxx xxxx 0009',
      'xxxx xxxx xxxx 0015',
    ];
    List<String> cardExpiry = [
      'January 1, 2021',
      'January 21, 2021',
      'March 7, 2021',
      'March 26, 2021',
    ]; // TODO: find a better use for this field
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
    List showBack = _getStorage.read('cardOrientation').length ==
            cardNumbers.length // if equal
        ? _getStorage.read('cardOrientation') // then use saved state
        : List<bool>.filled(cardNumbers.length, false,
            growable: true); // else, create a new bool list

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * Health card generator + divider (.separated)
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    return ListView.separated(
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
            cardExpiry: '${cardExpiry[index]}',
            cardHolderName: '${cardHolder[index]}',
            cvv: '${cvv[index]}',
            bankName: 'Universal Health Card',
            cardType: CardType.other,
            showBackSide: showBack[index],
            frontBackground: CardBackgrounds.black,
            backBackground: CardBackgrounds.white,
            showShadow: true,
            textExpDate: 'Issued on',
            textName: 'Name',
            textExpiry: 'MM/YY',
          ),
        );
      },
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      //  * Separator
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 0,
          height: 30,
        );
      },
    );
  }
}
