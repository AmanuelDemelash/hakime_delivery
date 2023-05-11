import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hakime_delivery/apiservice/mymutation.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/widgets/buttonspinner.dart';
import '../../controllers/logincontroller.dart';
import '../../utils/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

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
        backgroundColor: Constants.whitesmoke,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Change password",
          style: TextStyle(color: Colors.black),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: 
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Constants.primcolor.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                  child: const Center(
                    child: FaIcon(FontAwesomeIcons.key),
                  )),
              const SizedBox(height: 10,),
              const Text(
                "Create new password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                "Your new password must be different from \nprevious used password ",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formkey,
                  child: Column(
                children: [
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
                  GestureDetector(
                    onTap: () => Get.offAllNamed("/mainhomepage"),
                    child: const Text(
                      "Skip! i will change later",
                      style: TextStyle( fontWeight: FontWeight.bold),
                    ),
                  ),

                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
