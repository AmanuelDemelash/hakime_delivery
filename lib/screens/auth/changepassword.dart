import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Change password",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.white,
            )
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Please ")
            


          ],
        ),
      ),
    );
  }
}
