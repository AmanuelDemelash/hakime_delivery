import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/screens/auth/changepassword.dart';
import 'package:hakime_delivery/screens/delivery/activeorderdetail.dart';
import 'package:hakime_delivery/screens/delivery/complateorder.dart';
import 'package:hakime_delivery/screens/delivery/profile/bankinformation.dart';
import 'package:hakime_delivery/screens/delivery/profile/wallet.dart';
import 'package:hakime_delivery/screens/delivery/profile/widget/addbankinfo.dart';
import 'package:hakime_delivery/translations/apptranslations.dart';
import 'package:hakime_delivery/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bindings/appbinding.dart';
import 'screens/auth/forgotpassword.dart';
import 'screens/auth/login.dart';
import 'screens/auth/verificationcode.dart';
import 'screens/delivery/homepage.dart';
import 'screens/delivery/main_home_page.dart';
import 'screens/onbording/onbordscreen.dart';
import 'screens/onbording/splash.dart';
import 'screens/setting.dart';
import 'theme/light_theme.dart';

late final prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  // notification
  prefs = await SharedPreferences.getInstance();
  AwesomeNotifications().initialize(
      //set the icon to null if you want to use the default app icon
      'resource://drawable/logo',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Constants.primcolor,
            importance: NotificationImportance.High,
            ledColor: Colors.white),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          defaultColor: Constants.primcolor,
          importance: NotificationImportance.High,
          channelDescription: 'Notification channel for schdule',
        ),
      ],
      //Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HttpLink httpLink = HttpLink("https://hakime-2.hasura.app/v1/graphql",
        defaultHeaders: {"x-hasura-admin-secret": "hakime"});
    final WebSocketLink websocketLink = WebSocketLink(
      "wss://hakime-2.hasura.app/v1/graphql",
      config: const SocketClientConfig(
          autoReconnect: true,
          inactivityTimeout: Duration(seconds: 30),
          headers: {"x-hasura-admin-secret": "hakime"}),
    );
    final Link link = Link.split(
        (request) => request.isSubscription, websocketLink, httpLink);

    var token = prefs.getString("token");
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer <$token>',
    );
    final Link main_link = authLink.concat(link);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: main_link,
        // The default store is the InMemoryStofre, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: GetMaterialApp(
        initialBinding: AppBinding(),
        translations: AppTranslations(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.leftToRight,
        title: Constants.app_name,
        theme: light,
        initialRoute: "/splash",
        getPages: [
          GetPage(name: "/splash", page: () => Splash()),
          GetPage(name: "/login", page: () => Login()),
          GetPage(name: "/forgotpassword", page: () => ForgotPassword()),
          GetPage(name: "/homepage", page: () => Homepage()),
          GetPage(name: "/verification", page: () => VerificationCode()),
          GetPage(name: "/onbording", page: () => Onbordscreen()),
          GetPage(name: "/mainhomepage", page: () => MainHomePage()),
          GetPage(name: "/activeorderdetail", page: () => ActiveOrderDetail()),
          GetPage(name: "/complate", page: () => ComplateOrder()),
          GetPage(name: "/wallet", page: () => Wallet()),
          GetPage(name: "/bankinformation", page: () => Bankinformation()),
          GetPage(name: "/addbank", page: () => AddBankInformation()),
          GetPage(name: "/changepassword", page: () => ChangePassword()),

          // both screen
          GetPage(name: "/setting", page: () => Setting()),
        ],
      ),
    );
  }
}
