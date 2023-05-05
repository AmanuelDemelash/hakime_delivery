import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/myquery.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/widgets/cool_loading.dart';

import '../../../utils/constants.dart';
import 'widget/bankinfo_card.dart';

class Bankinformation extends StatelessWidget {
  Bankinformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "My Bank information",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            )),
      ),
      
      floatingActionButton: FloatingActionButton(
        tooltip: "Add bank info",
        backgroundColor: Constants.primcolor,
        onPressed: () async {
          Get.toNamed("/addbank");
        },
        child:const FaIcon(
          FontAwesomeIcons.add,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: 60,
            color: Constants.primcolor,
          ),
          Positioned(

            child: RefreshIndicator(
            onRefresh: () async {},
            color: Constants.primcolor,
            child: Container(
              width: Get.width,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top:25),
                decoration:const BoxDecoration(
                  color: Constants.whitesmoke,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                  
                ),
                child:
                Query(options: QueryOptions(document: gql(Myquery.bank_info),
                    variables: {
                      "id":Get.find<SplashController>().prefs.getInt("id")
                    },
                    pollInterval: const Duration(seconds: 10)
                ),

                  builder:(result, {fetchMore, refetch}) {
                    if(result.hasException){
                      return const cool_loding();
                    }
                    if(result.isLoading){
                      return const cool_loding();
                    }

                    List bank=result.data!["bank_informations"];
                    return ListView.builder(
                      itemCount:bank.length,
                      itemBuilder: (context, index) {
                        return bankinfo_card(
                          id:bank[index]["id"],
                          name: bank[index]["full_name"],
                          bname: bank[index]["bank_name"],
                          acc: bank[index]["account_number"],
                        );
                      },
                    );
                  },)

            ),
          ), )
        ],
      )

    );
  }
}
