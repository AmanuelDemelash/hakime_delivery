import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import 'widget/bankinfo_card.dart';

class Bankinformation extends StatelessWidget {
  Bankinformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "My Bank information",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(
          FontAwesomeIcons.add,
          color: Colors.white,
        ),
        tooltip: "Add bank info",
        onPressed: () async {
          Get.toNamed("/addbank");
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        color: Constants.primcolor,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return bankinfo_card();
          },
        ),
      ),
    );
  }
}
