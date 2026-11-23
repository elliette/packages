// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is run as part of a reduced test set in CI on Mac and Windows
// machines.
@Tags(<String>['reduced-test-set'])
library;

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'feedback_tester.dart';
import 'finders.dart';
import 'semantics_tester.dart';

void main() {
  final material3Theme = ThemeData();
  final material2Theme = ThemeData(useMaterial3: false);

  testWidgets('Floating Action Button control test', (WidgetTester tester) async {
    var didPressButton = false;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: FloatingActionButton(
            onPressed: () {
              didPressButton = true;
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );

    expect(didPressButton, isFalse);
    await tester.tap(find.byType(Icon));
    expect(didPressButton, isTrue);
  });

  testWidgets('Floating Action Button tooltip', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(Icon));
    expect(findByTooltip('Add'), findsOneWidget);
  });

  // Regression test for: https://github.com/flutter/flutter/pull/21084
  testWidgets('Floating Action Button tooltip (long press button edge)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );

    expect(find.text('Add'), findsNothing);
    await tester.longPressAt(_rightEdgeOfFab(tester));
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsOneWidget);
  });

  // Regression test for: https://github.com/flutter/flutter/pull/21084
  testWidgets('Floating Action Button tooltip (long press button edge - no child)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {}, tooltip: 'Add'),
        ),
      ),
    );

    expect(find.text('Add'), findsNothing);
    await tester.longPressAt(_rightEdgeOfFab(tester));
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsOneWidget);
  });

  testWidgets('Floating Action Button tooltip (no child)', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {}, tooltip: 'Add'),
        ),
      ),
    );

    expect(find.text('Add'), findsNothing);

    // Test hover for tooltip.
    final TestGesture gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer();
    addTearDown(gesture.removePointer);
    await gesture.moveTo(tester.getCenter(find.byType(FloatingActionButton)));
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsOneWidget);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsNothing);

    // Test long press for tooltip.
    await tester.longPress(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsOneWidget);
  });

  testWidgets('Floating Action Button tooltip reacts when disabled', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: null, tooltip: 'Add')),
      ),
    );

    expect(find.text('Add'), findsNothing);

    // Test hover for tooltip.
    final TestGesture gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer();
    addTearDown(gesture.removePointer);
    await tester.pumpAndSettle();
    await gesture.moveTo(tester.getCenter(find.byType(FloatingActionButton)));
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsOneWidget);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsNothing);

    // Test long press for tooltip.
    await tester.longPress(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Add'), findsOneWidget);
  });

  testWidgets('Floating Action Button elevation when highlighted - effect', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {})),
      ),
    );
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    final TestGesture gesture = await tester.press(find.byType(PhysicalShape));
    await tester.pump();
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {}, highlightElevation: 20.0),
        ),
      ),
    );
    await tester.pump();
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 20.0);
    await gesture.up();
    await tester.pump();
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 20.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
  });

  testWidgets('Floating Action Button elevation when disabled - defaults', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: null)),
      ),
    );

    // Disabled elevation defaults to regular default elevation.
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
  });

  testWidgets('Floating Action Button elevation when disabled - override', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: null, disabledElevation: 0),
        ),
      ),
    );

    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 0.0);
  });

  testWidgets('Floating Action Button elevation when disabled - effect', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: null)),
      ),
    );
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: null, disabledElevation: 3.0),
        ),
      ),
    );
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 3.0);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {}, disabledElevation: 3.0),
        ),
      ),
    );
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 3.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
  });

  testWidgets('Floating Action Button elevation when disabled while highlighted - effect', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {})),
      ),
    );
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.press(find.byType(PhysicalShape));
    await tester.pump();
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: const Scaffold(floatingActionButton: FloatingActionButton(onPressed: null)),
      ),
    );
    await tester.pump();
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {})),
      ),
    );
    await tester.pump();
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    await tester.pump(const Duration(seconds: 1));
    expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
  });

  testWidgets('Floating Action Button states elevation', (WidgetTester tester) async {
    final focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: Scaffold(
          body: FloatingActionButton.extended(
            label: const Text('tooltip'),
            onPressed: () {},
            focusNode: focusNode,
          ),
        ),
      ),
    );

    final Finder fabFinder = find.byType(PhysicalShape);
    PhysicalShape getFABWidget(Finder finder) => tester.widget<PhysicalShape>(finder);

    // Default, not disabled.
    expect(getFABWidget(fabFinder).elevation, 6);

    // Focused.
    focusNode.requestFocus();
    await tester.pumpAndSettle();
    expect(getFABWidget(fabFinder).elevation, 6);

    // Hovered.
    final Offset center = tester.getCenter(fabFinder);
    final TestGesture gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer();
    await gesture.moveTo(center);
    await tester.pumpAndSettle();
    expect(getFABWidget(fabFinder).elevation, 8);

    // Highlighted (pressed).
    await gesture.down(center);
    await tester.pump(); // Start the splash and highlight animations.
    await tester.pump(
      const Duration(milliseconds: 800),
    ); // Wait for splash and highlight to be well under way.
    expect(getFABWidget(fabFinder).elevation, 6);

    focusNode.dispose();
  });

  testWidgets('FlatActionButton mini size is configurable by ThemeData.materialTapTargetSize', (
    WidgetTester tester,
  ) async {
    final Key key1 = UniqueKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Theme(
          data: ThemeData(materialTapTargetSize: MaterialTapTargetSize.padded),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(key: key1, mini: true, onPressed: null),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byKey(key1)), const Size(48.0, 48.0));

    final Key key2 = UniqueKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Theme(
          data: ThemeData(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(key: key2, mini: true, onPressed: null),
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byKey(key2)), const Size(40.0, 40.0));
  });

  testWidgets('FloatingActionButton.isExtended', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: const Scaffold(floatingActionButton: FloatingActionButton(onPressed: null)),
      ),
    );

    final Finder fabFinder = find.byType(FloatingActionButton);

    FloatingActionButton getFabWidget() {
      return tester.widget<FloatingActionButton>(fabFinder);
    }

    final Finder materialButtonFinder = find.byType(RawMaterialButton);

    RawMaterialButton getRawMaterialButtonWidget() {
      return tester.widget<RawMaterialButton>(materialButtonFinder);
    }

    expect(getFabWidget().isExtended, false);
    expect(
      getRawMaterialButtonWidget().shape,
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: SizedBox(width: 100.0, child: Text('label')),
            icon: Icon(Icons.android),
            onPressed: null,
          ),
        ),
      ),
    );

    expect(getFabWidget().isExtended, true);
    expect(
      getRawMaterialButtonWidget().shape,
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    );
    expect(find.text('label'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);

    // Verify that the widget's height is 56 and that its internal
    /// horizontal layout is: 16 icon 8 label 20
    expect(tester.getSize(fabFinder).height, 56.0);

    final double fabLeft = tester.getTopLeft(fabFinder).dx;
    final double fabRight = tester.getTopRight(fabFinder).dx;
    final double iconLeft = tester.getTopLeft(find.byType(Icon)).dx;
    final double iconRight = tester.getTopRight(find.byType(Icon)).dx;
    final double labelLeft = tester.getTopLeft(find.text('label')).dx;
    final double labelRight = tester.getTopRight(find.text('label')).dx;
    expect(iconLeft - fabLeft, 16.0);
    expect(labelLeft - iconRight, 8.0);
    expect(fabRight - labelRight, 20.0);

    // The overall width of the button is:
    // 168 = 16 + 24(icon) + 8 + 100(label) + 20
    expect(tester.getSize(find.byType(Icon)).width, 24.0);
    expect(tester.getSize(find.text('label')).width, 100.0);
    expect(tester.getSize(fabFinder).width, 168);
  });

  testWidgets('FloatingActionButton.isExtended (without icon)', (WidgetTester tester) async {
    final Finder fabFinder = find.byType(FloatingActionButton);

    FloatingActionButton getFabWidget() {
      return tester.widget<FloatingActionButton>(fabFinder);
    }

    final Finder materialButtonFinder = find.byType(RawMaterialButton);

    RawMaterialButton getRawMaterialButtonWidget() {
      return tester.widget<RawMaterialButton>(materialButtonFinder);
    }

    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: const Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: SizedBox(width: 100.0, child: Text('label')),
            onPressed: null,
          ),
        ),
      ),
    );

    expect(getFabWidget().isExtended, true);
    expect(
      getRawMaterialButtonWidget().shape,
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
    );
    expect(find.text('label'), findsOneWidget);
    expect(find.byType(Icon), findsNothing);

    // Verify that the widget's height is 56 and that its internal
    /// horizontal layout is: 20 label 20
    expect(tester.getSize(fabFinder).height, 56.0);

    final double fabLeft = tester.getTopLeft(fabFinder).dx;
    final double fabRight = tester.getTopRight(fabFinder).dx;
    final double labelLeft = tester.getTopLeft(find.text('label')).dx;
    final double labelRight = tester.getTopRight(find.text('label')).dx;
    expect(labelLeft - fabLeft, 20.0);
    expect(fabRight - labelRight, 20.0);

    // The overall width of the button is:
    // 140 = 20 + 100(label) + 20
    expect(tester.getSize(find.text('label')).width, 100.0);
    expect(tester.getSize(fabFinder).width, 140);
  });

  testWidgets('Floating Action Button heroTag', (WidgetTester tester) async {
    late BuildContext theContext;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              theContext = context;
              return const FloatingActionButton(heroTag: 1, onPressed: null);
            },
          ),
          floatingActionButton: const FloatingActionButton(heroTag: 2, onPressed: null),
        ),
      ),
    );
    unawaited(
      Navigator.push(
        theContext,
        PageRouteBuilder<void>(
          pageBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return const Placeholder();
              },
        ),
      ),
    );
    await tester.pump(); // this would fail if heroTag was the same on both FloatingActionButtons (see below).
  });

  testWidgets('Floating Action Button heroTag - with duplicate', (WidgetTester tester) async {
    late BuildContext theContext;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              theContext = context;
              return const FloatingActionButton(onPressed: null);
            },
          ),
          floatingActionButton: const FloatingActionButton(onPressed: null),
        ),
      ),
    );
    unawaited(
      Navigator.push(
        theContext,
        PageRouteBuilder<void>(
          pageBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return const Placeholder();
              },
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException().toString(), contains('FloatingActionButton'));
  });

  testWidgets('Floating Action Button heroTag - with duplicate', (WidgetTester tester) async {
    late BuildContext theContext;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              theContext = context;
              return const FloatingActionButton(heroTag: 'xyzzy', onPressed: null);
            },
          ),
          floatingActionButton: const FloatingActionButton(heroTag: 'xyzzy', onPressed: null),
        ),
      ),
    );
    unawaited(
      Navigator.push(
        theContext,
        PageRouteBuilder<void>(
          pageBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return const Placeholder();
              },
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException().toString(), contains('xyzzy'));
  });

  testWidgets('Floating Action Button semantics (enabled)', (WidgetTester tester) async {
    final semantics = SemanticsTester(tester);

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add, semanticLabel: 'Add'),
          ),
        ),
      ),
    );

    expect(
      semantics,
      hasSemantics(
        TestSemantics.root(
          children: <TestSemantics>[
            TestSemantics.rootChild(
              label: 'Add',
              flags: <SemanticsFlag>[
                SemanticsFlag.hasEnabledState,
                SemanticsFlag.isButton,
                SemanticsFlag.isEnabled,
                SemanticsFlag.isFocusable,
              ],
              actions: <SemanticsAction>[SemanticsAction.tap, SemanticsAction.focus],
            ),
          ],
        ),
        ignoreTransform: true,
        ignoreId: true,
        ignoreRect: true,
      ),
    );

    semantics.dispose();
  });

  testWidgets('Floating Action Button semantics (disabled)', (WidgetTester tester) async {
    final semantics = SemanticsTester(tester);

    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add, semanticLabel: 'Add'),
          ),
        ),
      ),
    );

    expect(
      semantics,
      hasSemantics(
        TestSemantics.root(
          children: <TestSemantics>[
            TestSemantics.rootChild(
              label: 'Add',
              flags: <SemanticsFlag>[SemanticsFlag.isButton, SemanticsFlag.hasEnabledState],
            ),
          ],
        ),
        ignoreTransform: true,
        ignoreId: true,
        ignoreRect: true,
      ),
    );

    semantics.dispose();
  });

  testWidgets('Tooltip is used as semantics tooltip', (WidgetTester tester) async {
    final semantics = SemanticsTester(tester);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Add Photo',
            child: const Icon(Icons.add_a_photo),
          ),
        ),
      ),
    );

    expect(
      semantics,
      hasSemantics(
        TestSemantics.root(
          children: <TestSemantics>[
            TestSemantics.rootChild(
              children: <TestSemantics>[
                TestSemantics(
                  children: <TestSemantics>[
                    TestSemantics(
                      flags: <SemanticsFlag>[SemanticsFlag.scopesRoute],
                      children: <TestSemantics>[
                        TestSemantics(
                          tooltip: 'Add Photo',
                          actions: <SemanticsAction>[SemanticsAction.tap, SemanticsAction.focus],
                          flags: <SemanticsFlag>[
                            SemanticsFlag.hasEnabledState,
                            SemanticsFlag.isButton,
                            SemanticsFlag.isEnabled,
                            SemanticsFlag.isFocusable,
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        ignoreTransform: true,
        ignoreId: true,
        ignoreRect: true,
      ),
    );

    semantics.dispose();
  });

  testWidgets('extended FAB hero transitions succeed', (WidgetTester tester) async {
    // Regression test for https://github.com/flutter/flutter/issues/18782

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              // define context of Navigator.push()
              return FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                label: const Text('A long FAB label'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return Scaffold(
                          floatingActionButton: FloatingActionButton.extended(
                            icon: const Icon(Icons.add),
                            label: const Text('X'),
                            onPressed: () {},
                          ),
                          body: Center(
                            child: ElevatedButton(
                              child: const Text('POP'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          body: const Center(child: Text('Hello World')),
        ),
      ),
    );

    final Finder longFAB = find.text('A long FAB label');
    final Finder shortFAB = find.text('X');
    final Finder helloWorld = find.text('Hello World');

    expect(longFAB, findsOneWidget);
    expect(shortFAB, findsNothing);
    expect(helloWorld, findsOneWidget);

    await tester.tap(longFAB);
    await tester.pumpAndSettle();

    expect(shortFAB, findsOneWidget);
    expect(longFAB, findsNothing);

    // Trigger a hero transition from shortFAB to longFAB.
    await tester.tap(find.text('POP'));
    await tester.pumpAndSettle();

    expect(longFAB, findsOneWidget);
    expect(shortFAB, findsNothing);
    expect(helloWorld, findsOneWidget);
  });

  // This test prevents https://github.com/flutter/flutter/issues/20483
  testWidgets('Floating Action Button clips ink splash and highlight', (WidgetTester tester) async {
    final GlobalKey key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        theme: material3Theme,
        home: Scaffold(
          body: Center(
            child: RepaintBoundary(
              key: key,
              child: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
            ),
          ),
        ),
      ),
    );

    await tester.press(find.byKey(key));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1000));
    await expectLater(find.byKey(key), matchesGoldenFile('floating_action_button_test.clip.png'));
  });

  testWidgets('Floating Action Button changes mouse cursor when hovered', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton.extended(
              onPressed: () {},
              mouseCursor: SystemMouseCursors.text,
              label: const Text('label'),
              icon: const Icon(Icons.android),
            ),
          ),
        ),
      ),
    );

    final TestGesture gesture = await tester.createGesture(
      kind: PointerDeviceKind.mouse,
      pointer: 1,
    );
    await gesture.addPointer(location: tester.getCenter(find.byType(FloatingActionButton)));

    await tester.pump();

    expect(
      RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
      SystemMouseCursors.text,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(
              onPressed: () {},
              mouseCursor: SystemMouseCursors.text,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );

    await gesture.moveTo(tester.getCenter(find.byType(FloatingActionButton)));
    expect(
      RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
      SystemMouseCursors.text,
    );

    // Test default cursor
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
          ),
        ),
      ),
    );

    expect(
      RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
      kIsWeb ? SystemMouseCursors.click : SystemMouseCursors.basic,
    );

    // Test default cursor when disabled
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: FloatingActionButton(onPressed: null, child: Icon(Icons.add)),
          ),
        ),
      ),
    );

    expect(
      RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
      SystemMouseCursors.basic,
    );
  }, tags: 'reduced-web-test-set');

  testWidgets('Floating Action Button has no clip by default', (WidgetTester tester) async {
    final focusNode = FocusNode();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: FloatingActionButton(
          focusNode: focusNode,
          onPressed: () {
            /* to make sure the button is enabled */
          },
        ),
      ),
    );

    focusNode.unfocus();
    await tester.pump();

    expect(
      tester.renderObject(find.byType(FloatingActionButton)),
      paintsExactlyCountTimes(#clipPath, 0),
    );

    focusNode.dispose();
  });

  testWidgets('Can find FloatingActionButton semantics', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FloatingActionButton(onPressed: () {})));

    expect(
      tester.getSemantics(find.byType(FloatingActionButton)),
      matchesSemantics(
        hasTapAction: true,
        hasFocusAction: true,
        hasEnabledState: true,
        isButton: true,
        isEnabled: true,
        isFocusable: true,
      ),
    );
  });

  testWidgets('Foreground color applies to icon on fab', (WidgetTester tester) async {
    const foregroundColor = Color(0xcafefeed);

    await tester.pumpWidget(
      MaterialApp(
        home: FloatingActionButton(
          onPressed: () {},
          foregroundColor: foregroundColor,
          child: const Icon(Icons.access_alarm),
        ),
      ),
    );

    final RichText iconRichText = tester.widget<RichText>(
      find.descendant(of: find.byIcon(Icons.access_alarm), matching: find.byType(RichText)),
    );
    expect(iconRichText.text.style!.color, foregroundColor);
  });

  testWidgets('FloatingActionButton uses custom splash color', (WidgetTester tester) async {
    const splashColor = Color(0xcafefeed);

    await tester.pumpWidget(
      MaterialApp(
        theme: material2Theme,
        home: FloatingActionButton(
          onPressed: () {},
          splashColor: splashColor,
          child: const Icon(Icons.access_alarm),
        ),
      ),
    );

    await tester.press(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), paints..circle(color: splashColor));
  });

  testWidgets('extended FAB does not show label when isExtended is false', (
    WidgetTester tester,
  ) async {
    const iconKey = Key('icon');
    const labelKey = Key('label');

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: FloatingActionButton.extended(
          isExtended: false,
          label: const Text('', key: labelKey),
          icon: const Icon(Icons.add, key: iconKey),
          onPressed: () {},
        ),
      ),
    );

    // Verify that Icon is present and label is not.
    expect(find.byKey(iconKey), findsOneWidget);
    expect(find.byKey(labelKey), findsNothing);
  });

  testWidgets('FloatingActionButton.small configures correct size', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton.small(
            key: key,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: null,
          ),
        ),
      ),
    );

    expect(tester.getSize(find.byKey(key)), const Size(40.0, 40.0));
  });

  testWidgets('FloatingActionButton.large configures correct size', (WidgetTester tester) async {
    final Key key = UniqueKey();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(floatingActionButton: FloatingActionButton.large(key: key, onPressed: null)),
      ),
    );

    expect(tester.getSize(find.byKey(key)), const Size(96.0, 96.0));
  });

  testWidgets('FloatingActionButton.extended can customize spacing', (WidgetTester tester) async {
    const iconKey = Key('icon');
    const labelKey = Key('label');
    const spacing = 33.0;
    const padding = EdgeInsetsDirectional.only(start: 5.0, end: 6.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('', key: labelKey),
            icon: const Icon(Icons.add, key: iconKey),
            extendedIconLabelSpacing: spacing,
            extendedPadding: padding,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(
      tester.getTopLeft(find.byKey(labelKey)).dx - tester.getTopRight(find.byKey(iconKey)).dx,
      spacing,
    );
    expect(
      tester.getTopLeft(find.byKey(iconKey)).dx -
          tester.getTopLeft(find.byType(FloatingActionButton)).dx,
      padding.start,
    );
    expect(
      tester.getTopRight(find.byType(FloatingActionButton)).dx -
          tester.getTopRight(find.byKey(labelKey)).dx,
      padding.end,
    );
  });

  testWidgets('FloatingActionButton.extended can customize text style', (
    WidgetTester tester,
  ) async {
    const labelKey = Key('label');
    const style = TextStyle(letterSpacing: 2.0);

    await tester.pumpWidget(
      MaterialApp(
        theme: material2Theme,
        home: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('', key: labelKey),
            icon: const Icon(Icons.add),
            extendedTextStyle: style,
            onPressed: () {},
          ),
        ),
      ),
    );

    final RawMaterialButton rawMaterialButton = tester.widget<RawMaterialButton>(
      find.descendant(
        of: find.byType(FloatingActionButton),
        matching: find.byType(RawMaterialButton),
      ),
    );
    // The color comes from the default color scheme's onSecondary value.
    expect(rawMaterialButton.textStyle, style.copyWith(color: const Color(0xffffffff)));
  });

  group('Material 2', () {
    // These tests are only relevant for Material 2. Once Material 2
    // support is deprecated and the APIs are removed, these tests
    // can be deleted.

    testWidgets('Floating Action Button elevation when highlighted - effect', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {})),
        ),
      );
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
      final TestGesture gesture = await tester.press(find.byType(PhysicalShape));
      await tester.pump();
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
      await tester.pump(const Duration(seconds: 1));
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 12.0);
      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: () {}, highlightElevation: 20.0),
          ),
        ),
      );
      await tester.pump();
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 12.0);
      await tester.pump(const Duration(seconds: 1));
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 20.0);
      await gesture.up();
      await tester.pump();
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 20.0);
      await tester.pump(const Duration(seconds: 1));
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    });

    testWidgets('Floating Action Button elevation when disabled while highlighted - effect', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {})),
        ),
      );
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
      await tester.press(find.byType(PhysicalShape));
      await tester.pump();
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
      await tester.pump(const Duration(seconds: 1));
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 12.0);
      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: const Scaffold(floatingActionButton: FloatingActionButton(onPressed: null)),
        ),
      );
      await tester.pump();
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 12.0);
      await tester.pump(const Duration(seconds: 1));
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {})),
        ),
      );
      await tester.pump();
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
      await tester.pump(const Duration(seconds: 1));
      expect(tester.widget<PhysicalShape>(find.byType(PhysicalShape)).elevation, 6.0);
    });

    testWidgets('Floating Action Button states elevation', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: Scaffold(
            body: FloatingActionButton.extended(
              label: const Text('tooltip'),
              onPressed: () {},
              focusNode: focusNode,
            ),
          ),
        ),
      );

      final Finder fabFinder = find.byType(PhysicalShape);
      PhysicalShape getFABWidget(Finder finder) => tester.widget<PhysicalShape>(finder);

      // Default, not disabled.
      expect(getFABWidget(fabFinder).elevation, 6);

      // Focused.
      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(getFABWidget(fabFinder).elevation, 6);

      // Hovered.
      final Offset center = tester.getCenter(fabFinder);
      final TestGesture gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      await gesture.moveTo(center);
      await tester.pumpAndSettle();
      expect(getFABWidget(fabFinder).elevation, 8);

      // Highlighted (pressed).
      await gesture.down(center);
      await tester.pump(); // Start the splash and highlight animations.
      await tester.pump(
        const Duration(milliseconds: 800),
      ); // Wait for splash and highlight to be well under way.
      expect(getFABWidget(fabFinder).elevation, 12);

      focusNode.dispose();
    });

    testWidgets('FloatingActionButton.isExtended', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: const Scaffold(floatingActionButton: FloatingActionButton(onPressed: null)),
        ),
      );

      final Finder fabFinder = find.byType(FloatingActionButton);

      FloatingActionButton getFabWidget() {
        return tester.widget<FloatingActionButton>(fabFinder);
      }

      final Finder materialButtonFinder = find.byType(RawMaterialButton);

      RawMaterialButton getRawMaterialButtonWidget() {
        return tester.widget<RawMaterialButton>(materialButtonFinder);
      }

      expect(getFabWidget().isExtended, false);
      expect(getRawMaterialButtonWidget().shape, const CircleBorder());

      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: const Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              label: SizedBox(width: 100.0, child: Text('label')),
              icon: Icon(Icons.android),
              onPressed: null,
            ),
          ),
        ),
      );

      expect(getFabWidget().isExtended, true);
      expect(getRawMaterialButtonWidget().shape, const StadiumBorder());
      expect(find.text('label'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);

      // Verify that the widget's height is 48 and that its internal
      /// horizontal layout is: 16 icon 8 label 20
      expect(tester.getSize(fabFinder).height, 48.0);

      final double fabLeft = tester.getTopLeft(fabFinder).dx;
      final double fabRight = tester.getTopRight(fabFinder).dx;
      final double iconLeft = tester.getTopLeft(find.byType(Icon)).dx;
      final double iconRight = tester.getTopRight(find.byType(Icon)).dx;
      final double labelLeft = tester.getTopLeft(find.text('label')).dx;
      final double labelRight = tester.getTopRight(find.text('label')).dx;
      expect(iconLeft - fabLeft, 16.0);
      expect(labelLeft - iconRight, 8.0);
      expect(fabRight - labelRight, 20.0);

      // The overall width of the button is:
      // 168 = 16 + 24(icon) + 8 + 100(label) + 20
      expect(tester.getSize(find.byType(Icon)).width, 24.0);
      expect(tester.getSize(find.text('label')).width, 100.0);
      expect(tester.getSize(fabFinder).width, 168);
    });

    testWidgets('FloatingActionButton.isExtended (without icon)', (WidgetTester tester) async {
      final Finder fabFinder = find.byType(FloatingActionButton);

      FloatingActionButton getFabWidget() {
        return tester.widget<FloatingActionButton>(fabFinder);
      }

      final Finder materialButtonFinder = find.byType(RawMaterialButton);

      RawMaterialButton getRawMaterialButtonWidget() {
        return tester.widget<RawMaterialButton>(materialButtonFinder);
      }

      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: const Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              label: SizedBox(width: 100.0, child: Text('label')),
              onPressed: null,
            ),
          ),
        ),
      );

      expect(getFabWidget().isExtended, true);
      expect(getRawMaterialButtonWidget().shape, const StadiumBorder());
      expect(find.text('label'), findsOneWidget);
      expect(find.byType(Icon), findsNothing);

      // Verify that the widget's height is 48 and that its internal
      /// horizontal layout is: 20 label 20
      expect(tester.getSize(fabFinder).height, 48.0);

      final double fabLeft = tester.getTopLeft(fabFinder).dx;
      final double fabRight = tester.getTopRight(fabFinder).dx;
      final double labelLeft = tester.getTopLeft(find.text('label')).dx;
      final double labelRight = tester.getTopRight(find.text('label')).dx;
      expect(labelLeft - fabLeft, 20.0);
      expect(fabRight - labelRight, 20.0);

      // The overall width of the button is:
      // 140 = 20 + 100(label) + 20
      expect(tester.getSize(find.text('label')).width, 100.0);
      expect(tester.getSize(fabFinder).width, 140);
    });

    // This test prevents https://github.com/flutter/flutter/issues/20483
    testWidgets('Floating Action Button clips ink splash and highlight', (
      WidgetTester tester,
    ) async {
      final GlobalKey key = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          theme: material2Theme,
          home: Scaffold(
            body: Center(
              child: RepaintBoundary(
                key: key,
                child: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
              ),
            ),
          ),
        ),
      );

      await tester.press(find.byKey(key));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 1000));
      await expectLater(
        find.byKey(key),
        matchesGoldenFile('floating_action_button_test_m2.clip.png'),
      );
    });
  });

  group('feedback', () {
    late FeedbackTester feedback;

    setUp(() {
      feedback = FeedbackTester();
    });

    tearDown(() {
      feedback.dispose();
    });

    testWidgets('FloatingActionButton with enabled feedback', (WidgetTester tester) async {
      const enableFeedback = true;

      await tester.pumpWidget(
        MaterialApp(
          home: FloatingActionButton(
            onPressed: () {},
            enableFeedback: enableFeedback,
            child: const Icon(Icons.access_alarm),
          ),
        ),
      );

      await tester.tap(find.byType(RawMaterialButton));
      await tester.pump(const Duration(seconds: 1));
      expect(feedback.clickSoundCount, 1);
      expect(feedback.hapticCount, 0);
    });

    testWidgets('FloatingActionButton with disabled feedback', (WidgetTester tester) async {
      const enableFeedback = false;

      await tester.pumpWidget(
        MaterialApp(
          home: FloatingActionButton(
            onPressed: () {},
            enableFeedback: enableFeedback,
            child: const Icon(Icons.access_alarm),
          ),
        ),
      );

      await tester.tap(find.byType(RawMaterialButton));
      await tester.pump(const Duration(seconds: 1));
      expect(feedback.clickSoundCount, 0);
      expect(feedback.hapticCount, 0);
    });

    testWidgets('FloatingActionButton with enabled feedback by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.access_alarm)),
        ),
      );

      await tester.tap(find.byType(RawMaterialButton));
      await tester.pump(const Duration(seconds: 1));
      expect(feedback.clickSoundCount, 1);
      expect(feedback.hapticCount, 0);
    });

    testWidgets('FloatingActionButton with disabled feedback using FloatingActionButtonTheme', (
      WidgetTester tester,
    ) async {
      const enableFeedbackTheme = false;
      final theme = ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          enableFeedback: enableFeedbackTheme,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Theme(
            data: theme,
            child: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.access_alarm)),
          ),
        ),
      );

      await tester.tap(find.byType(RawMaterialButton));
      await tester.pump(const Duration(seconds: 1));
      expect(feedback.clickSoundCount, 0);
      expect(feedback.hapticCount, 0);
    });

    testWidgets(
      'FloatingActionButton.enableFeedback is overridden by FloatingActionButtonThemeData.enableFeedback',
      (WidgetTester tester) async {
        const enableFeedbackTheme = false;
        const enableFeedback = true;
        final theme = ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            enableFeedback: enableFeedbackTheme,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Theme(
              data: theme,
              child: FloatingActionButton(
                enableFeedback: enableFeedback,
                onPressed: () {},
                child: const Icon(Icons.access_alarm),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(RawMaterialButton));
        await tester.pump(const Duration(seconds: 1));
        expect(feedback.clickSoundCount, 1);
        expect(feedback.hapticCount, 0);
      },
    );
  });

  testWidgets('FloatingActionButton does not crash at zero area', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: Center(
            child: SizedBox.shrink(child: FloatingActionButton(onPressed: () {})),
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(FloatingActionButton)), Size.zero);
  });

  group('Material 3 Expressive', () {
    final m3eTheme = ThemeData(
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        variant: StyleVariant.material3Expressive,
      ),
    );

    Finder materialFinder() {
      return find.descendant(
        of: find.byType(FloatingActionButton),
        matching: find.byType(Material),
      );
    }

    Material getMaterial(WidgetTester tester) => tester.widget<Material>(materialFinder());

    InkWell getInkWell(WidgetTester tester) {
      return tester.widget<InkWell>(
        find.descendant(of: find.byType(FloatingActionButton), matching: find.byType(InkWell)),
      );
    }

    Color? getIconColor(WidgetTester tester) {
      return tester
          .widget<RichText>(
            find.descendant(of: find.byIcon(Icons.add), matching: find.byType(RichText)),
          )
          .text
          .style!
          .color;
    }

    Future<void> pumpFab(WidgetTester tester, Widget fab, {ThemeData? theme}) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme ?? m3eTheme,
          home: Scaffold(floatingActionButton: fab),
        ),
      );
      // Let the button's implicit animations, such as the icon size, settle.
      await tester.pumpAndSettle();
    }

    testWidgets('Material 3 remains the default', (WidgetTester tester) async {
      await pumpFab(tester, FloatingActionButton(onPressed: () {}), theme: ThemeData());
      expect(find.byType(RawMaterialButton), findsOneWidget);
    });

    testWidgets('The variant has no effect when useMaterial3 is false', (
      WidgetTester tester,
    ) async {
      await pumpFab(
        tester,
        FloatingActionButton(onPressed: () {}),
        theme: ThemeData(
          useMaterial3: false,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            variant: StyleVariant.material3Expressive,
          ),
        ),
      );
      expect(find.byType(RawMaterialButton), findsOneWidget);
    });

    testWidgets('A nested FloatingActionButtonTheme can opt a subtree back out', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: m3eTheme,
          home: Scaffold(
            body: FloatingActionButtonTheme(
              data: const FloatingActionButtonThemeData(variant: StyleVariant.material3),
              child: FloatingActionButton(onPressed: () {}, heroTag: 'm3'),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {}),
          ),
        ),
      );
      expect(find.byType(RawMaterialButton), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(FloatingActionButtonTheme),
          matching: find.byType(RawMaterialButton),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Default values', (WidgetTester tester) async {
      const colorScheme = ColorScheme.light();
      await pumpFab(
        tester,
        FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
        theme: ThemeData(
          colorScheme: colorScheme,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            variant: StyleVariant.material3Expressive,
          ),
        ),
      );

      expect(find.byType(RawMaterialButton), findsNothing);
      final Material material = getMaterial(tester);
      expect(material.color, colorScheme.primaryContainer);
      expect(material.shadowColor, colorScheme.shadow);
      expect(material.surfaceTintColor, Colors.transparent);
      expect(material.elevation, 6.0);
      expect(
        material.shape,
        const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      );
      expect(tester.getSize(materialFinder()), const Size(56.0, 56.0));
      expect(tester.getSize(find.byIcon(Icons.add)), const Size(24.0, 24.0));
      expect(getIconColor(tester), colorScheme.onPrimaryContainer);

      final WidgetStateProperty<Color?> overlayColor = getInkWell(tester).overlayColor!;
      expect(
        overlayColor.resolve(<WidgetState>{WidgetState.pressed}),
        colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
      );
      expect(
        overlayColor.resolve(<WidgetState>{WidgetState.hovered}),
        colorScheme.onPrimaryContainer.withValues(alpha: 0.08),
      );
      expect(
        overlayColor.resolve(<WidgetState>{WidgetState.focused}),
        colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
      );
      expect(overlayColor.resolve(<WidgetState>{}), isNull);
    });

    testWidgets('Sizes, shapes, and icon sizes', (WidgetTester tester) async {
      Future<void> expectFab(
        Widget fab, {
        required Size size,
        required double radius,
        required double iconSize,
      }) async {
        await pumpFab(tester, fab);
        expect(find.byType(RawMaterialButton), findsNothing);
        expect(tester.getSize(materialFinder()), size);
        expect(
          getMaterial(tester).shape,
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius))),
        );
        expect(tester.getSize(find.byIcon(Icons.add)), Size.square(iconSize));
      }

      await expectFab(
        FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.add)),
        size: const Size(40.0, 40.0),
        radius: 12.0,
        iconSize: 24.0,
      );
      await expectFab(
        FloatingActionButton(mini: true, onPressed: () {}, child: const Icon(Icons.add)),
        size: const Size(40.0, 40.0),
        radius: 12.0,
        iconSize: 24.0,
      );
      await expectFab(
        FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
        size: const Size(56.0, 56.0),
        radius: 16.0,
        iconSize: 24.0,
      );
      await expectFab(
        FloatingActionButton.large(onPressed: () {}, child: const Icon(Icons.add)),
        size: const Size(96.0, 96.0),
        radius: 28.0,
        iconSize: 36.0,
      );
    });

    testWidgets('The small floating action button has a padded tap target', (
      WidgetTester tester,
    ) async {
      final Key key = UniqueKey();
      await pumpFab(tester, FloatingActionButton.small(key: key, onPressed: () {}));
      expect(tester.getSize(find.byKey(key)), const Size(48.0, 48.0));
      expect(tester.getSize(materialFinder()), const Size(40.0, 40.0));
    });

    for (final TextDirection textDirection in TextDirection.values) {
      testWidgets('Extended floating action button defaults in ${textDirection.name}', (
        WidgetTester tester,
      ) async {
        const iconKey = Key('icon');
        const labelKey = Key('label');
        await tester.pumpWidget(
          MaterialApp(
            theme: m3eTheme,
            home: Directionality(
              textDirection: textDirection,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(Icons.add, key: iconKey),
                  label: const Text('Extended', key: labelKey),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(RawMaterialButton), findsNothing);
        final ThemeData theme = Theme.of(tester.element(find.byType(FloatingActionButton)));
        final Rect materialRect = tester.getRect(materialFinder());
        expect(materialRect.height, 56.0);
        expect(
          getMaterial(tester).shape,
          const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        );
        expect(
          getMaterial(tester).textStyle,
          theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onPrimaryContainer),
        );
        final Rect iconRect = tester.getRect(find.byKey(iconKey));
        final Rect labelRect = tester.getRect(find.byKey(labelKey));
        expect(iconRect.size, const Size(24.0, 24.0));
        if (textDirection == TextDirection.ltr) {
          expect(iconRect.left - materialRect.left, 16.0);
          expect(labelRect.left - iconRect.right, 8.0);
          expect(materialRect.right - labelRect.right, 16.0);
        } else {
          expect(materialRect.right - iconRect.right, 16.0);
          expect(iconRect.left - labelRect.right, 8.0);
          expect(labelRect.left - materialRect.left, 16.0);
        }
      });
    }

    testWidgets('Extended floating action button without isExtended shows only the icon', (
      WidgetTester tester,
    ) async {
      await pumpFab(
        tester,
        FloatingActionButton.extended(
          onPressed: () {},
          isExtended: false,
          icon: const Icon(Icons.add),
          label: const Text('Extended'),
        ),
      );

      expect(find.text('Extended'), findsNothing);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('The state layer follows foregroundColor', (WidgetTester tester) async {
      const foregroundColor = Color(0xFF00FF00);
      await pumpFab(
        tester,
        FloatingActionButton(
          onPressed: () {},
          foregroundColor: foregroundColor,
          child: const Icon(Icons.add),
        ),
      );

      final WidgetStateProperty<Color?> overlayColor = getInkWell(tester).overlayColor!;
      expect(
        overlayColor.resolve(<WidgetState>{WidgetState.pressed}),
        foregroundColor.withValues(alpha: 0.1),
      );
      expect(
        overlayColor.resolve(<WidgetState>{WidgetState.hovered}),
        foregroundColor.withValues(alpha: 0.08),
      );
      expect(
        overlayColor.resolve(<WidgetState>{WidgetState.focused}),
        foregroundColor.withValues(alpha: 0.1),
      );
      expect(getIconColor(tester), foregroundColor);
    });

    testWidgets('Explicit state layer colors take priority over foregroundColor', (
      WidgetTester tester,
    ) async {
      const foregroundColor = Color(0xFF00FF00);
      const splashColor = Color(0xFF000001);
      const hoverColor = Color(0xFF000002);
      const focusColor = Color(0xFF000003);
      await pumpFab(
        tester,
        FloatingActionButton(
          onPressed: () {},
          foregroundColor: foregroundColor,
          splashColor: splashColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
          child: const Icon(Icons.add),
        ),
      );

      final WidgetStateProperty<Color?> overlayColor = getInkWell(tester).overlayColor!;
      expect(overlayColor.resolve(<WidgetState>{WidgetState.pressed}), splashColor);
      expect(overlayColor.resolve(<WidgetState>{WidgetState.hovered}), hoverColor);
      expect(overlayColor.resolve(<WidgetState>{WidgetState.focused}), focusColor);
    });

    testWidgets('Material 3 state layer does not follow foregroundColor', (
      WidgetTester tester,
    ) async {
      const colorScheme = ColorScheme.light();
      await pumpFab(
        tester,
        FloatingActionButton(
          onPressed: () {},
          foregroundColor: const Color(0xFF00FF00),
          child: const Icon(Icons.add),
        ),
        theme: ThemeData(colorScheme: colorScheme),
      );

      expect(
        tester.widget<RawMaterialButton>(find.byType(RawMaterialButton)).splashColor,
        colorScheme.onPrimaryContainer.withOpacity(0.1),
      );
    });

    testWidgets('Elevation for each state', (WidgetTester tester) async {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await pumpFab(
        tester,
        FloatingActionButton(onPressed: () {}, focusNode: focusNode, child: const Icon(Icons.add)),
      );
      expect(getMaterial(tester).elevation, 6.0);

      final TestGesture gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      addTearDown(gesture.removePointer);
      await gesture.moveTo(tester.getCenter(find.byType(FloatingActionButton)));
      await tester.pumpAndSettle();
      expect(getMaterial(tester).elevation, 8.0);

      await gesture.down(tester.getCenter(find.byType(FloatingActionButton)));
      await tester.pump();
      expect(getMaterial(tester).elevation, 6.0);
      await gesture.up();
      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle();

      FocusManager.instance.highlightStrategy = FocusHighlightStrategy.alwaysTraditional;
      focusNode.requestFocus();
      await tester.pumpAndSettle();
      expect(getMaterial(tester).elevation, 6.0);
      FocusManager.instance.highlightStrategy = FocusHighlightStrategy.automatic;
    });

    testWidgets('Widget elevations map to each state', (WidgetTester tester) async {
      await pumpFab(
        tester,
        FloatingActionButton(
          onPressed: () {},
          elevation: 1.0,
          hoverElevation: 2.0,
          highlightElevation: 3.0,
          child: const Icon(Icons.add),
        ),
      );
      expect(getMaterial(tester).elevation, 1.0);

      final TestGesture gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      addTearDown(gesture.removePointer);
      await gesture.moveTo(tester.getCenter(find.byType(FloatingActionButton)));
      await tester.pumpAndSettle();
      expect(getMaterial(tester).elevation, 2.0);

      await gesture.down(tester.getCenter(find.byType(FloatingActionButton)));
      await tester.pump();
      expect(getMaterial(tester).elevation, 3.0);
      await gesture.up();
    });

    testWidgets('A disabled floating action button uses elevation when disabledElevation is null', (
      WidgetTester tester,
    ) async {
      await pumpFab(tester, const FloatingActionButton(onPressed: null));
      expect(getMaterial(tester).elevation, 6.0);

      await pumpFab(tester, const FloatingActionButton(onPressed: null, elevation: 3.0));
      expect(getMaterial(tester).elevation, 3.0);

      await pumpFab(
        tester,
        const FloatingActionButton(onPressed: null, elevation: 3.0, disabledElevation: 1.0),
      );
      expect(getMaterial(tester).elevation, 1.0);
    });

    testWidgets('A shape that is not an OutlinedBorder asserts', (WidgetTester tester) async {
      await pumpFab(tester, FloatingActionButton(onPressed: () {}, shape: Border.all()));
      expect(tester.takeException(), isAssertionError);
    });

    testWidgets('Compact visual density does not change the size', (WidgetTester tester) async {
      await pumpFab(
        tester,
        FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
        theme: m3eTheme.copyWith(visualDensity: VisualDensity.compact),
      );
      expect(tester.getSize(materialFinder()), const Size(56.0, 56.0));
    });

    testWidgets('Tooltip, Hero, and semantics are kept', (WidgetTester tester) async {
      final semantics = SemanticsTester(tester);
      await pumpFab(
        tester,
        FloatingActionButton(
          onPressed: () {},
          tooltip: 'Add tooltip',
          heroTag: 'fab',
          child: const Icon(Icons.add, semanticLabel: 'Add'),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);
      expect(tester.widget<Hero>(find.byType(Hero)).tag, 'fab');
      expect(
        semantics,
        includesNodeWith(
          label: 'Add',
          flags: <SemanticsFlag>[
            SemanticsFlag.hasEnabledState,
            SemanticsFlag.isButton,
            SemanticsFlag.isEnabled,
            SemanticsFlag.isFocusable,
          ],
          actions: <SemanticsAction>[SemanticsAction.tap, SemanticsAction.focus],
        ),
      );
      semantics.dispose();
    });

    testWidgets('Widget properties are used', (WidgetTester tester) async {
      var pressed = false;
      await pumpFab(
        tester,
        FloatingActionButton(
          onPressed: () => pressed = true,
          backgroundColor: const Color(0xFF000001),
          shape: const StadiumBorder(),
          mouseCursor: SystemMouseCursors.text,
          clipBehavior: Clip.antiAlias,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: const Icon(Icons.add),
        ),
      );

      expect(getMaterial(tester).color, const Color(0xFF000001));
      expect(getMaterial(tester).shape, const StadiumBorder());
      expect(getMaterial(tester).clipBehavior, Clip.antiAlias);
      await tester.tap(find.byType(FloatingActionButton));
      expect(pressed, isTrue);

      final TestGesture gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      addTearDown(gesture.removePointer);
      await gesture.moveTo(tester.getCenter(find.byType(FloatingActionButton)));
      await tester.pumpAndSettle();
      expect(
        RendererBinding.instance.mouseTracker.debugDeviceActiveCursor(1),
        SystemMouseCursors.text,
      );
    });
  });
}

Offset _rightEdgeOfFab(WidgetTester tester) {
  final Finder fab = find.byType(FloatingActionButton);
  return tester.getRect(fab).centerRight - const Offset(1.0, 0.0);
}
