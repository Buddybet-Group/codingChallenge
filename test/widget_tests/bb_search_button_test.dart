import 'package:coding_chal/global_widgets/bb_search_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late Widget rootWidget;
  const String buttonTitle = "Let's Find Out";
  bool isClicked = false;

  setUp(() {
    rootWidget = MaterialApp(
      home: Scaffold(
        body: BBSearchButton(
          buttonTitle: buttonTitle,
          onClick: () {
            isClicked = true;
          },
        ),
      ),
    );
  });

  testWidgets('ensure text visibility', (WidgetTester tester) async {
    await tester.pumpWidget(rootWidget);
    await tester.pumpAndSettle();

    expect(find.text(buttonTitle), findsOneWidget);
  });

  testWidgets('ensure click event trigger', (WidgetTester tester) async {
    isClicked = false;

    await tester.pumpWidget(rootWidget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BBSearchButton));
    await tester.pump();

    expect(isClicked, true);
  });
}
