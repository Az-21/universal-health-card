import 'package:flutter/material.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Statess dashboard
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            // FIXME: Create card builder
            Card(),
            Card(),
            Card(),
            Card(),
            Card(),
            Card(),
            Card(),
            Card(),
          ],
        )));
  }
}
