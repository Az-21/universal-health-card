// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pub Dev Imports
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';

class SyncHealthCard extends StatelessWidget {
  const SyncHealthCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: Text('Sync Health Card'),
      ),
      body: FetchHealthCardForm(),
    );
  }
}

class FetchHealthCardForm extends StatelessWidget {
  const FetchHealthCardForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        /// Info Card
        GFCard(
          color: Colors.green,
          title: GFListTile(
            title: GFTypography(
              text: 'Fetch Health Card',
              showDivider: false,
              textColor: Colors.white,
              type: GFTypographyType.typo3,
              icon: Icon(
                Icons.file_download,
                color: Colors.white,
                size: 32,
              ),
              dividerColor: Colors.white,
              dividerWidth: 100,
            ),
            subtitle: GFTypography(
              text: 'Add an existing health card to your device.',
              textColor: Colors.white,
              type: GFTypographyType.typo5,
              showDivider: false,
            ),
          ),
        ),

        /// Input Form
        HealthCardSyncForm(),
      ],
    );
  }
}

class HealthCardSyncForm extends StatefulWidget {
  HealthCardSyncForm({Key key}) : super(key: key);

  @override
  _HealthCardSyncFormState createState() => _HealthCardSyncFormState();
}

class _HealthCardSyncFormState extends State<HealthCardSyncForm> {
  TextEditingController formSecurityKey = TextEditingController();
  TextEditingController formAadhar = TextEditingController();

  bool isFirebaseSuccess = false; // on sync

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context); // next focus
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// Aadhar ID
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: formAadhar,
            maxLength: 14, // input formatter will add 12 + 2 = 14
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              counterText: '',
              labelText: 'Aadhar UID',
              hintText: '12 Digit AADHAR Card Number',
            ),
            inputFormatters: [
              CreditCardFormatter(),
            ],
            textInputAction: TextInputAction.next,
            onEditingComplete: () => focus.nextFocus(),
          ),
        ),

        /// Security Key / CVV
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: formSecurityKey,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              counterText: '',
              labelText: 'Security Key',
              hintText: 'Four digit security key',
            ),
            maxLength: 4,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.done,
            onEditingComplete: () => focus.unfocus(),
          ),
        ),

        /// Submit Button
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GFButton(
            text: "Fetch Health Card",
            size: GFSize.LARGE,
            elevation: 5,
            color: Colors.blue,
            splashColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            icon: Icon(
              Icons.cloud_download_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: validator here -> 4 digit key, 12 digit aadhar...
              // TODO: firebase push here
              isFirebaseSuccess = false;
              if (isFirebaseSuccess) {
                Get.snackbar(
                  'Success',
                  'Health card has been added',
                  icon: Icon(Icons.cloud_done_sharp),
                  backgroundColor: Colors.blue,
                );
                // Reset all text fields
                formSecurityKey.text = '';
                formAadhar.text = '';
              } else {
                Get.snackbar(
                  'Failed',
                  'Failed to fetch health card. Please check your internet connection. Ensure health card with specified security key exists.',
                  icon: Icon(Icons.signal_wifi_off_sharp),
                  backgroundColor: Colors.redAccent,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
