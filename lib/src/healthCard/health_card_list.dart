// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:awesome_card/awesome_card.dart';
import 'package:get_storage/get_storage.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Health Card List
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class HealthCardPage extends StatefulWidget {
  const HealthCardPage({Key? key}) : super(key: key);

  @override
  _HealthCardPageState createState() => _HealthCardPageState();
}

class _HealthCardPageState extends State<HealthCardPage> {
  // * Firestore hook
  Query<Map<String, dynamic>> cards = FirebaseFirestore.instance
      .collection('cards')
      .orderBy('name', descending: false);

  // * Shared prefs
  final _getStorage = GetStorage();

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

    // * Default placeholders (fallback in case of inactive internet)
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

    // * Update local cards cache
    FirebaseFirestore.instance
        .collection("cards")
        .orderBy('name', descending: false)
        .get()
        .then((querySnapshot) {
      final List<String> localCards = [];
      querySnapshot.docs.forEach((result) {
        String firstname = result.data()['name'].toString().split(' ')[0];
        String aadhar = result.data()['aadhar'].toString();
        localCards.add('$firstname | $aadhar');
      });
      _getStorage.write('localCards', localCards);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: cards.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                //  * Rebuild card on tap -> animate
                onTap: () {
                  setState(() {
                    showBack[index] = !showBack[index];
                  });
                },

                //  * Core health card
                child: CreditCard(
                  cardNumber: snapshot.data!.docs[index]['aadhar'].toString(),
                  cardExpiry:
                      snapshot.data!.docs[index]['healthCondition'].toString(),
                  cardHolderName: snapshot.data!.docs[index]['name'].toString(),
                  cvv: snapshot.data!.docs[index]['cvv'].toString(),
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

            //  * Separator
            separatorBuilder: (context, index) {
              return const SizedBox(height: 32);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
