import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/mymutation.dart';
import 'package:hakime_delivery/controllers/bankinfocontroller.dart';
import 'package:hakime_delivery/widgets/buttonspinner.dart';

import '../../../../utils/constants.dart';

class bankinfo_card extends StatefulWidget {
  int id;
  String name;
  String bname;
  String acc;

  bankinfo_card(
      {Key? key,
      required this.id,
      required this.name,
      required this.acc,
      required this.bname})
      : super(key: key);

  @override
  State<bankinfo_card> createState() => _bankinfo_cardState();
}

class _bankinfo_cardState extends State<bankinfo_card> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: 100,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Bank Name : ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(widget.bname)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    "Account no : ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(widget.acc)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    "Holder Name : ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(widget.name)
                ],
              ),
            ],
          ),
        ),

        // delet button
        Positioned(
          right: 10,
          top: 0,
          child: Container(
              width: 40,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(20))),
              child: Mutation(
                options:
                    MutationOptions(document: gql(Mymutation.delet_bankinfo),
                    onCompleted: (data) {
                      Get.find<BankinfoController>().is_deletingbank.value=false;
                        setState(() {

                        });
                    },
                    ),
                builder: (runMutation, result) {
                  if(result!.hasException){
                    Get.find<BankinfoController>().is_deletingbank.value=false;
                  }
                  if(result!.isLoading){
                    Get.find<BankinfoController>().is_deletingbank.value=true;
                  }
                  return IconButton(
                      onPressed: () {
                        // run muttion
                        runMutation({
                          "id":widget.id
                        });
                      },
                      icon:Center(
                        child: Get.find<BankinfoController>().is_deletingbank.value==true?const ButtonSpinner():const FaIcon(
                          FontAwesomeIcons.remove,
                          color: Colors.white,
                        ),
                      ));
                },
              )),
        )
      ],
    );
  }
}
