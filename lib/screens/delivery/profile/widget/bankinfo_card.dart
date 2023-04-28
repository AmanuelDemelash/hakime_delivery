import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';

class bankinfo_card extends StatelessWidget {
  const bankinfo_card({
    Key? key,
  }) : super(key: key);

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
                children: const [
                  Text(
                    "Bank Name : ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text("CBE")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: const [
                  Text(
                    "Account no : ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text("1000307762377")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: const [
                  Text(
                    "Holder Name : ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text("Amnauel demelash")
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
                color: Constants.primcolor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(20))),
            child: IconButton(
                onPressed: () {},
                icon: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.remove,
                    color: Colors.white,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
