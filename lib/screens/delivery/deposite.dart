
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/constants.dart';

class Deposit extends StatelessWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primcolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Deposit",
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
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: 60,
            color: Constants.primcolor,
          ),
          Container(
        width: Get.width,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top:25),
        decoration:const BoxDecoration(
            color: Constants.whitesmoke,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
        ),
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const SizedBox(
                height: 50,
              ),
             const Text("Recharge your wallet",style: TextStyle(fontSize: 18),),
              const Text("please popup your wallet to get orders ",style: TextStyle(color: Colors.black54),),
              const SizedBox(height:50,),
              const Text("Choose method",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ExpansionTile(title:const Text("Bank Transfer"),
               textColor: Constants.primcolor,
               subtitle: const Text("Deposit through our bank "),
               childrenPadding: const EdgeInsets.all(10),
               children: [
                 Container(
                   width:Get.width,
                   padding:const EdgeInsets.all(15),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10)

                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:const [
                       Text("CBE:  10087655",style: TextStyle(fontWeight: FontWeight.bold),),
                       SizedBox(height: 5,),
                       Text("Abysinya: 10087655",style: TextStyle(fontWeight: FontWeight.bold),),
                       SizedBox(height: 5,),
                       Text("Amhara Bank : 10087655",style: TextStyle(fontWeight: FontWeight.bold),),

                     ],
                   ),
                 ),
                const  SizedBox(height: 20,),
                 const Text("After transferring to hakime account you need to provide transaction number below ",style:TextStyle(color: Colors.black54),),
                 const  SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == "") {

                        } else {
                          return null;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "transaction number",
                          filled: true,
                          contentPadding: const EdgeInsets.all(15),
                          prefixIcon: const Icon(Icons.numbers),
                          errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Constants.whitesmoke),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Constants.primcolor),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Constants.primcolor.withOpacity(0.2)),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                          fillColor: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  // send button
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(onPressed:() {

                    }, child:const Text("Send",style: TextStyle(color: Colors.white),)),
                  )
                ],
              ),

                 const SizedBox(width: 20,),
               ]),
              ExpansionTile(title:Row(
                children: [
                  Image(image: AssetImage("assets/images/chapa.png")),
                   Text("Chapa")
                ],
              ),
              subtitle:const Text("deposit through chapa"),
              textColor: Constants.primcolor,
              childrenPadding:const EdgeInsets.all(15),
              children: [
                Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == "") {

                              } else {
                                return null;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "amount ",
                                filled: true,
                                contentPadding: const EdgeInsets.all(15),
                                prefixIcon: const Icon(Icons.numbers),
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Constants.whitesmoke),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Constants.primcolor),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Constants.primcolor.withOpacity(0.2)),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                                fillColor: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SizedBox(
                          child: ElevatedButton(onPressed:() {

                          }, child:const Text("deposit",style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    )
              ],),
            ],
          ),
        )

      )
        ],
      ),

    );
  }
}
