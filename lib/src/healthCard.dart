// Dart native imports
import 'package:flutter/material.dart';

// Pub dev imports
import 'package:expansion_card/expansion_card.dart';

class HealthCards extends StatefulWidget {
  HealthCards({Key key}) : super(key: key);

  @override
  _HealthCardsState createState() => _HealthCardsState();
}

class _HealthCardsState extends State<HealthCards> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ExpansionCard(
      leading: const Icon(Icons.person_pin_rounded),
      borderRadius: 12,
      title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Az21",
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            Text(
              "0000 0000 0000 0021",
            ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "TODO: implement full details",
                ),
                Text(
                  "TODO: implement QR and barcode generator using 16 digit identifier",
                ),
              ]),
        )
      ],
    ));
  }
}
