import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';

class AddBankInformation extends StatelessWidget {
  AddBankInformation({super.key});

  var _formkey = GlobalKey<FormState>();
  TextEditingController bname = TextEditingController();
  TextEditingController holdername = TextEditingController();
  TextEditingController accountnum = TextEditingController();

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
        body: Container(
          width: Get.width,
          decoration: const BoxDecoration(),
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
                                  } else {
                                    return null;
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
                              // customsnack("add account number");
                            } else {
                              return null;
                            }
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
                              //customsnack("add bank holder name");
                            } else {
                              return null;
                            }
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
                        SizedBox(
                          width: Get.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(17)),
                                onPressed: () {
                                  _formkey.currentState!.save();

                                },
                                child: const Text("Save")),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
