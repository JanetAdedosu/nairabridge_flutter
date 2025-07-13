import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nairabridge_flutter/main.dart';

void main() {
  testWidgets('NavigationWrapper renders Home and Transfer tabs', (WidgetTester tester) async {
    await tester.pumpWidget(NairabridgeApp());

    // Verify Home tab is initially shown
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    // Tap Transfer tab
    await tester.tap(find.byIcon(Icons.swap_horiz));
    await tester.pumpAndSettle();

    // Now we should be on the Transfer tab
    expect(find.text('Transfer'), findsOneWidget);
  });
}
