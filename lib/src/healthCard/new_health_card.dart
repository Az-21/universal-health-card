// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:flutter/services.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:health_app/src/functions.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Formfield UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class NewHealthCard extends StatelessWidget {
  const NewHealthCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HealthCardCreateForm(),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Stateful Health Form
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class HealthCardCreateForm extends StatefulWidget {
  const HealthCardCreateForm({Key? key}) : super(key: key);

  @override
  _HealthCardCreateFormState createState() => _HealthCardCreateFormState();
}

class _HealthCardCreateFormState extends State<HealthCardCreateForm> {
  // * Placeholders
  String aadharNumber = 'xxxx xxxx xxxx';
  String cardHolderName = '';
  String bloodGroup = '';
  String healthCondition = '';
  String healthInfo = ''; // = '$bloodGroup | $healthCondition'
  String cvv = '';
  bool showBack = false;

  FocusNode? _focusNode; // for card animation

  // * Controllers to reset text on submit
  TextEditingController formAadhar = TextEditingController();
  TextEditingController formBloodGroup = TextEditingController();
  TextEditingController formHealthCondition = TextEditingController();
  TextEditingController formName = TextEditingController();
  TextEditingController formSecurityKey = TextEditingController();

  // * Firebase hook
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('cards');

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode!.addListener(() {
      setState(() {
        _focusNode!.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context); // next focus
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          CreditCard(
            cardNumber: aadharNumber,
            cardExpiry: healthInfo,
            cardHolderName: cardHolderName,
            cvv: cvv,
            cardType: CardType.other,
            bankName: 'Universal Health Card',
            showBackSide: showBack,
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
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Security Key / CVV
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formSecurityKey,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    counterText: '',
                    labelText: 'Security Key',
                    hintText: 'Set a four digit security key',
                  ),
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (formSecuurityKey) {
                    setState(() {
                      cvv = formSecuurityKey;
                    });
                  },
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => focus.nextFocus(),
                ),
              ),

              /// Name
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formName,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Name',
                    counterText: '',
                    hintText: 'First Last',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (formName) {
                    setState(() {
                      cardHolderName = formName;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => focus.nextFocus(),
                ),
              ),

              /// Aadhar ID
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formAadhar,
                  maxLength: 14, // input formatter will add 12 + 2 = 14
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.qr_code),
                    border: OutlineInputBorder(),
                    counterText: '',
                    labelText: 'Aadhar UID',
                    hintText: '12 Digit AADHAR Card Number',
                  ),
                  inputFormatters: [
                    CreditCardFormatter(),
                  ],
                  onChanged: (formAadhar) {
                    setState(() {
                      aadharNumber = formAadhar;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => focus.nextFocus(),
                ),
              ),

              /// Blood Group
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formBloodGroup,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.invert_colors),
                    border: OutlineInputBorder(),
                    counterText: '',
                    labelText: 'Blood Group',
                    hintText: 'AB+',
                  ),
                  maxLength: 3,
                  onChanged: (formBloodGroup) {
                    setState(() {
                      bloodGroup = formBloodGroup;
                      healthInfo = '$bloodGroup | $healthCondition';
                    });
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => focus.nextFocus(),
                ),
              ),

              /// Health Condition
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formHealthCondition,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.healing),
                    border: OutlineInputBorder(),
                    counterText: '',
                    labelText: 'Health Condition',
                    hintText: 'Allergic to X | Normal | High BP',
                  ),
                  maxLength: 20,
                  onChanged: (formHealthCondition) {
                    setState(() {
                      healthCondition = formHealthCondition;
                      healthInfo = '$bloodGroup | $healthCondition';
                    });
                  },
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => focus.unfocus(),
                ),
              ),

              /// Submit Button
              Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  icon: const Icon(Icons.post_add),
                  label: const Text('Create New Health Card'),
                  onPressed: () async {
                    await collectionReference
                        .add({
                          'cvv': formSecurityKey.text,
                          'name': formName.text,
                          'aadhar': formAadhar.text,
                          'bloodGroup': formBloodGroup.text,
                          'healthCondition': formHealthCondition.text,
                        })
                        .then((value) => infoSnackbar('Success',
                            'Health card added to the database', true))
                        .catchError((error) => infoSnackbar(
                            'Failed to create health card', '$error', false));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
