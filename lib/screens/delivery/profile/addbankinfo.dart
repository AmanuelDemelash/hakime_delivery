import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/mymutation.dart';
import 'package:hakime_delivery/controllers/bankinfocontroller.dart';
import 'package:hakime_delivery/controllers/splashcontroller.dart';
import 'package:hakime_delivery/widgets/buttonspinner.dart';

import '../../../utils/constants.dart';

class AddBankInformation extends StatelessWidget {
  AddBankInformation({super.key});

  var _formkey = GlobalKey<FormState>();
  TextEditingController bname = TextEditingController();
  TextEditingController holdername = TextEditingController();
  TextEditingController accountnum = TextEditingController();

  customsnacke(String message) {
    return Get.snackbar("Successful", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        maxWidth: Get.width,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
        padding: const EdgeInsets.all(10));
  }
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
            "Add Bank information",
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
        body:
            Stack(
              children: [
                Container(
                  width: Get.width,
                  height: 60,
                  color: Constants.primcolor,
                ),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Constants.whitesmoke,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height:20,
                        ),
                        const Text(
                          "Add Bank Information!",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        const Text(
                          "to make withdrawals from your account",
                          style: TextStyle( color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                // bank type
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: bname,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            customsnack("add bank name");
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            hintText: "Bank Type",
                                            enabled: false,
                                            filled: true,
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constants.whitesmoke),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constants.whitesmoke),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constants.whitesmoke),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Constants.whitesmoke),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(15)),
                                        child: PopupMenuButton(
                                          icon:
                                          const FaIcon(FontAwesomeIcons.angleDown),
                                          onSelected: (value) {
                                            bname.text = value.toString();
                                          },
                                          itemBuilder: (context) => const [
                                            PopupMenuItem(
                                                value: "CBE",
                                                child: Text(
                                                    "Commercial bank of ethiopia")),
                                            PopupMenuItem(
                                                value: "Abysiniya Bank",
                                                child: Text("Abysiniya Bank")),
                                            PopupMenuItem(
                                                value: "Amhara Bank",
                                                child: Text("Amhara Bank"))
                                          ],
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Account number
                                TextFormField(
                                  controller: accountnum,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      customsnack("add account number");
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Account number",
                                      enabled: true,
                                      filled: true,
                                      disabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      fillColor: Colors.white),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // holder name
                                TextFormField(
                                  controller: holdername,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      customsnack("add bank holder name");
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Account holder name",
                                      enabled: true,
                                      filled: true,
                                      disabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Constants.whitesmoke),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(25))),
                                      fillColor: Colors.white),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // button
                                Mutation(options: MutationOptions(document: gql(Mymutation.insert_bankinfo),
                                  onCompleted: (data) {
                                    if(data!.isNotEmpty){
                                      Get.find<BankinfoController>().is_addbank.value=false;
                                      Get.back();
                                      customsnacke("bank info add successfully");

                                    }

                                  },
                                  onError: (error) => customsnack(error!.graphqlErrors.first.message),
                                ),
                                  builder: (runMutation, result) {
                                    if(result!.hasException){
                                      Get.find<BankinfoController>().is_addbank.value=false;
                                      print(result.exception.toString());
                                    }


                                    if(result!.isLoading){
                                      Get.find<BankinfoController>().is_addbank.value=true;

                                    }
                                    return SizedBox(
                                      width: Get.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.all(17)),
                                            onPressed: () {
                                              _formkey.currentState!.save();
                                              if(bname.text.isNotEmpty || accountnum.text.isNotEmpty || bname.text.isNotEmpty){
                                                // run mutation
                                                runMutation({
                                                  "bank_name":bname.text,
                                                  "name":holdername.text,
                                                  "acc":accountnum.text,
                                                  "id":Get.find<SplashController>().prefs.getInt("id")
                                                });

                                              }else{
                                                customsnack("please provide correct information");
                                              }
                                            },
                                            child: Get.find<BankinfoController>().is_addbank.value==true? const ButtonSpinner():
                                            const Text("Save")),
                                      ),
                                    );
                                  },)

                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )
       
    );
  }
}
