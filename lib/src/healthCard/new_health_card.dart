// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';
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
    return Scaffold(
      body: HealthCardCreateForm(),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Stateful Health Form
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class HealthCardCreateForm extends StatefulWidget {
  HealthCardCreateForm({Key? key}) : super(key: key);

  @override
  _HealthCardCreateFormState createState() => _HealthCardCreateFormState();
}

class _HealthCardCreateFormState extends State<HealthCardCreateForm> {
  String aadharNumber = 'xxxx xxxx xxxx';
  String cardHolderName = '';
  String bloodGroup = '';
  String healthCondition = '';
  String healthInfo = ''; // = '$bloodGroup | $healthCondition'
  String cvv = '';
  bool showBack = false;

  FocusNode? _focusNode; // for card animation

  bool isFirebaseSuccess = false; // for firebase integration

  // Controllers to reset text on submit
  TextEditingController formAadhar = TextEditingController();
  TextEditingController formBloodGroup = TextEditingController();
  TextEditingController formHealthCondition = TextEditingController();
  TextEditingController formName = TextEditingController();
  TextEditingController formSecurityKey = TextEditingController();

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
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
          SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Security Key / CVV
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formSecurityKey,
                  decoration: InputDecoration(
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formName,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formAadhar,
                  maxLength: 14, // input formatter will add 12 + 2 = 14
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formBloodGroup,
                  decoration: InputDecoration(
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: formHealthCondition,
                  decoration: InputDecoration(
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    // minimumSize: Size(200, 100),
                  ),
                  icon: Icon(Icons.post_add),
                  label: Text('Create New Health Card'),
                  onPressed: () {
                    // TODO: validator here -> 4 digit key, 12 digit aadhar...
                    // TODO: firebase push here
                    isFirebaseSuccess = false;
                    if (isFirebaseSuccess) {
                      infoSnackbar(
                          'Success', 'Your health card has been created', true);
                      // Reset all text fields
                      formSecurityKey.text = '';
                      formName.text = '';
                      formAadhar.text = '';
                      formBloodGroup.text = '';
                      formHealthCondition.text = '';
                    } else {
                      infoSnackbar(
                          'Failed',
                          'Unable to create card. Please check your internet connection.',
                          false);
                    }
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
