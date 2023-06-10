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
import 'package:hakime_delivery/controllers/logincontroller.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/screens/auth/login.dart';
import 'package:hakime_delivery/screens/delivery/dashbord.dart';

void main()async{
 // WidgetsFlutterBinding.ensureInitialized();
 // await initHiveForFlutter();
  TestWidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(()=>LoginController());

  HttpLink httpLink = HttpLink("https://gedi.hasura.app/v1/graphql",
      defaultHeaders: {"x-hasura-admin-secret": "hakime"});
  final WebSocketLink websocketLink = WebSocketLink(
    "wss://gedi.hasura.app/v1/graphql",
    config: const SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
        headers: {"x-hasura-admin-secret": "hakime"}),
  );
  final Link link = Link.split(
          (request) => request.isSubscription, websocketLink, httpLink);

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <>',
  );
  final Link main_link = authLink.concat(link);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: main_link,
      // The default store is the InMemoryStofre, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  testWidgets("test home", (widgetTester)async{
   await widgetTester.pumpWidget(
      GraphQLProvider(
        client: client,
        child: GetMaterialApp(
            home:Login()),
      )
    );
   var ui=find.byType(TextFormField);
   expect(ui, findsOneWidget);
  });
}
