import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/splashcontroller.dart';

class Myprofile extends StatelessWidget {
  Myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // profile
            Container(
              width: Get.width,
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100))),
              child:
             Query(
               options:QueryOptions(document: gql(Myquery.delivery_profile_header),
               variables: {
                 "id":Get.find<SplashController>().prefs.getInt("id")
               }
               ) ,
             builder:(result, {fetchMore, refetch}) {
               if(result.hasException){
                 print(result.exception.toString());
               }
               if(result.isLoading){
                   return Column(
                     children: [
                       const SizedBox(height: 10,),
                       Shimmer.fromColors(
                         baseColor: Colors.grey.shade200,
                         highlightColor: Colors.white,
                         child: Container(
                           width: 100,
                           height: 110,
                           decoration: const BoxDecoration(
                               color: Colors.white,
                             shape: BoxShape.circle
                               ),
                         ),
                       ),
                       const SizedBox(height: 10,),

                       Shimmer.fromColors(
                         baseColor: Colors.grey.shade200,
                         highlightColor: Colors.white,
                         child: Container(
                           width: 120,
                           height: 10,
                           decoration: const BoxDecoration(
                               color: Colors.white,

                               ),
                         ),
                       ),
                       const SizedBox(height: 6,),
                       Shimmer.fromColors(
                         baseColor: Colors.grey.shade200,
                         highlightColor: Colors.white,
                         child: Container(
                           width: 80,
                           height: 10,
                           decoration: const BoxDecoration(
                             color: Colors.white,

                           ),
                         ),
                       ),
                     ],
                   );
                 }

               Map<String,dynamic> delivery=result.data!["deliverers_by_pk"];
               
               return  Column(
                 children: [
                   const SizedBox(
                     height: 10,
                   ),
                   CircleAvatar(
                       radius: 60,
                       backgroundImage:NetworkImage(delivery["image"]["url"])),

                   const SizedBox(
                     height: 10,
                   ),
                    Text(
                     delivery["full_name"],
                     style:const TextStyle(fontWeight: FontWeight.bold),
                   ),
                    Text(
                     delivery["phone_number"],
                     style:const TextStyle(fontWeight: FontWeight.bold),
                   ),
                 ],
               );
             }
             ),
            ),
            const SizedBox(
              height: 20,
            ),
            //edit account
            ListTile(
              onTap: () => Get.toNamed("/editprofile"),
              leading: const Icon(Icons.person),
              title: const Text("Edit Account"),
            ),
            //wallet
            ListTile(
              onTap: () => Get.toNamed("/wallet"),
              leading: const FaIcon(FontAwesomeIcons.wallet),
              title: const Text("Wallet"),
            ),
            // bank information
            ListTile(
              onTap: () => Get.toNamed("/bankinformation"),
              leading: const FaIcon(FontAwesomeIcons.bank),
              title: const Text("Bank information"),
            ),
            //nptification
            ListTile(
              onTap: () {
                Get.toNamed("/notification");
              },
              leading: const FaIcon(FontAwesomeIcons.bell),
              title: Text("notification".tr),
            ),
            //lamguage
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.earth),
              title: Text('language'.tr),
              trailing: PopupMenuButton(
                padding: const EdgeInsets.only(left: 40),
                icon: const FaIcon(FontAwesomeIcons.angleRight),
                onSelected: (value) {
                  if (value == 'am') {
                    Get.updateLocale(Locale('am', 'ET'));
                  }
                  if (value == 'en') {
                    Get.updateLocale(Locale('en', 'US'));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'en', child: Text("English")),
                  const PopupMenuItem(value: 'am', child: Text("Amharic")),
                ],
              ),
            ),
            //theme
            ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text("Dark Mode"),
                trailing: Switch.adaptive(
                  value: false,
                  onChanged: (value) {},
                )),
            //help
            const ListTile(
              leading: FaIcon(FontAwesomeIcons.servicestack),
              title: Text("Help center"),
            ),
            ListTile(
              onTap: () async {
                await Get.find<SplashController>().prefs.remove('id');
                await Get.find<SplashController>().prefs.remove('token');
                Get.offAllNamed("/login");
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
