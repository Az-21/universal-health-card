// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pub Dev Imports
import 'package:health_app/src/functions.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class SyncHealthCard extends StatelessWidget {
  const SyncHealthCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FetchHealthCardForm(),
    );
  }
}

class FetchHealthCardForm extends StatelessWidget {
  const FetchHealthCardForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        /// * Info Card
        Card(
          color: Colors.blue,
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // * Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.system_update_alt,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Fetch Health Card',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),

                // * Subtitle
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Add an existing health card to your device.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// * Input Form
        const HealthCardSyncForm(),
      ],
    );
  }
}

class HealthCardSyncForm extends StatefulWidget {
  const HealthCardSyncForm({Key? key}) : super(key: key);

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// Aadhar ID
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: formAadhar,
            maxLength: 14, // input formatter will add 12 + 2 = 14
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
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
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: formSecurityKey,
            decoration: const InputDecoration(
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
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            icon: const Icon(Icons.cloud_download),
            label: const Text('Fetch health card'),
            onPressed: () {
              // TODO: validator here -> 4 digit key, 12 digit aadhar...
              // TODO: firebase push here
              isFirebaseSuccess = true;
              if (isFirebaseSuccess) {
                infoSnackbar('Success',
                    'Health card has been added to your device', true);

                // Reset all text fields
                formSecurityKey.text = '';
                formAadhar.text = '';
              } else {
                infoSnackbar(
                    'Failed', 'Please check your internet connection', false);
              }
            },
          ),
        ),
      ],
    );
  }
}
