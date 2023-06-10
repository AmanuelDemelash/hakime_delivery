

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../apiservice/mymutation.dart';
import '../../../controllers/logincontroller.dart';
import '../../../controllers/splashcontroller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/buttonspinner.dart';

class EditAccount extends StatelessWidget {
  EditAccount({Key? key}) : super(key: key);


  final _formkey = GlobalKey<FormState>();
  final TextEditingController _oldpassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();

  customsnack(String message) {
    return Get.snackbar("Error", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        maxWidth: Get.width,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        padding: const EdgeInsets.all(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Update Profile",
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Form(
                key: _formkey,
                child: 
                Padding(
                  padding:const EdgeInsets.all(15),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Password",
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        height:10,
                      ),
                      // old password
                      Obx(() => TextFormField(
                        controller: _oldpassword,
                        obscureText:
                        Get.find<LoginController>().password_visible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return customsnack("please enter old  password");
                          } else if (value.length < 6) {
                            return customsnack("Password length must be 6");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: "old password",
                            filled: true,
                            prefixIcon: const Icon(Icons.key_sharp),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Get.find<LoginController>()
                                      .password_visible
                                      .value =
                                  !Get.find<LoginController>()
                                      .password_visible
                                      .value;
                                },
                                icon: Get.find<LoginController>()
                                    .password_visible
                                    .value ==
                                    true
                                    ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black45,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  color: Colors.black45,
                                )),
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constants.primcolor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.primcolor.withOpacity(0.2)),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                            fillColor: Colors.white),
                      )),
                      const SizedBox(
                        height:20,
                      ),
                      // new password
                      Obx(() => TextFormField(
                        controller: _newpassword,

                        obscureText:
                        Get.find<LoginController>().password_visible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return customsnack("please enter new  password");
                          } else if (value.length < 6) {
                            return customsnack("Password length must be 6");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: "new password",
                            helperText: "password size must be 6",
                            filled: true,
                            prefixIcon: const Icon(Icons.key_sharp),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Get.find<LoginController>()
                                      .password_visible
                                      .value =
                                  !Get.find<LoginController>()
                                      .password_visible
                                      .value;
                                },
                                icon: Get.find<LoginController>()
                                    .password_visible
                                    .value ==
                                    true
                                    ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black45,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  color: Colors.black45,
                                )),
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constants.whitesmoke),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constants.primcolor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.primcolor.withOpacity(0.2)),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                            fillColor: Colors.white),
                      )
                      ),
                      const SizedBox(height: 30,),

                      // change password button
                      SizedBox(
                          width: Get.width,
                          height: 50,
                          child: Mutation(options: MutationOptions(document: gql(Mymutation.change_password),
                            onCompleted:  (data) {
                              if(data!.isNotEmpty){
                                Get.find<LoginController>().is_changing_password.value=false;
                                Get.toNamed("/mainhomepage");
                              }
                            },
                            onError: (error) {
                              customsnack(error!.graphqlErrors.first.message.toString());
                              Get.find<LoginController>().is_changing_password.value=false;

                            },
                          ),
                            builder: (runMutation, result) {
                              if(result!.hasException){
                                Get.find<LoginController>().is_changing_password.value=false;
                              }

                              if(result!.isLoading){
                                Get.find<LoginController>().is_changing_password.value=true;
                              }

                              return Obx(() => ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding:const EdgeInsets.all(10)
                                    ),
                                    onPressed:() {
                                      _formkey.currentState!.save();
                                      if(_formkey.currentState!.validate()){
                                        // run mutation
                                        runMutation({
                                          "id":Get.find<SplashController>().prefs.getInt("id"),
                                          "old":_oldpassword.text.toString(),
                                          "new":_newpassword.text.toString()
                                        });

                                      }else{
                                        customsnack("please enter correct  password");
                                      }
                                    }, child:Get.find<LoginController>().is_changing_password.value==true?const ButtonSpinner():
                                const Text("Change password",style: TextStyle(color: Colors.white),)),
                              ) )
                              ;
                            },)
                      ),
                      const SizedBox(height: 30,),


                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
