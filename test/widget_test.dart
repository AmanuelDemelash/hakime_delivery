// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/bindings/appbinding.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/screens/delivery/dashbord.dart';

void main()async{
 // WidgetsFlutterBinding.ensureInitialized();
 // await initHiveForFlutter();
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("test home", (widgetTester)async{


   await widgetTester.pumpWidget(
      GetMaterialApp(
          home: Dashbord())
    );
   var ui=find.text("welcome");
   expect(ui, findsOneWidget);
  });
}
