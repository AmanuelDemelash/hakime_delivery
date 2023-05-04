import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hakime_delivery/apiservice/mymutation.dart';

import '../../controllers/orderconteroller.dart';
import '../../utils/constants.dart';

class ComplateOrder extends StatelessWidget {
   ComplateOrder({super.key});
  var order_data=Get.arguments;

   TextEditingController textcodecontroller=TextEditingController();
  final _formkey=GlobalKey<FormState>();


   getsnackbar(String mesg){
     Get.snackbar("error", mesg,
         snackPosition:SnackPosition.BOTTOM,
         backgroundColor: Colors.red,
         colorText: Colors.white
     );

   }
   getconfirmsnackbar(String mesg){
     Get.snackbar("successfully", mesg,
         snackPosition:SnackPosition.BOTTOM,
         backgroundColor: Colors.red,
         colorText: Colors.white
     );

   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.whitesmoke,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "Complete Order",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const FaIcon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Pharmacy"),
                  ),
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl:
                            order_data["phimage"],
                        width: 45,
                        height: 45,
                        placeholder: (context, url) => Icon(
                          Icons.image,
                          color: Constants.primcolor.withOpacity(0.5),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title:  Text(
                      order_data["phname"],
                      style:const TextStyle(),
                    ),
                    subtitle: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Constants.primcolor.withOpacity(0.5),
                          size: 14,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                         Flexible(
                          child: Text(
                            order_data["phloc"],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Order detail"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Order date",
                          style: TextStyle(color: Colors.black54),
                        ),
                       const SizedBox(
                          width: 10,
                        ),
                        Text(order_data["date"].toString().substring(0,9))
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                       const Text(
                          "Total",
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(" ETB ${order_data["dcost"] +order_data["tcost"]}")
                      ],
                    ),
                  )
                ],
              ),
            ),

            // payment option
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Payment detail"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.moneyBill),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Cash on delivery")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Enter Order Code to Complete the Order!"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Order Code*"),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key:_formkey ,
                    child:TextField(
                    controller:textcodecontroller,
                    decoration:const InputDecoration(
                        hintText: "Enter order code",
                        filled: true,
                        prefixIcon:Icon(Icons.password),
                        prefixIconColor: Constants.primcolor,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primcolor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primcolor)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Constants.primcolor)),
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Constants.primcolor))),
                  ), ),

                 const  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            // swaip button
            Container(
              margin: const EdgeInsets.all(20),
              child:
                  Mutation(options: MutationOptions(document: gql(Mymutation.completeorder),
                  onError: (error) {
                    Get.find<OrderController>().is_completing.value=false;
                  },
                    onCompleted: (data) {
                      if(data!.isNotEmpty){
                        Get.find<OrderController>().is_completing.value=false;
                        getconfirmsnackbar("successfully completed");
                        Get.toNamed("/mainhomepage");
                      }
                    },
                  ),
                      builder:(runMutation, result) {
                    if(result!.hasException){
                      print(result.exception.toString());
                      Get.find<OrderController>().is_completing.value=false;
                    }

                    if(result!.isLoading){
                      Get.find<OrderController>().is_completing.value=true;
                    }


                    return  Center(

                        child:
                            Obx(() => SwipeButton(
                              width: Get.width,
                              height: 60,

                              thumb:Get.find<OrderController>().is_completing.value==true?const CircularProgressIndicator(
                                color: Colors.white,
                              ) :const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  color: Colors.white,
                                ),
                              ),
                              onSwipeStart: ()async{
                                _formkey.currentState!.save();
                                if(textcodecontroller.text==""){
                                  getsnackbar("please enter order code to complete the task ");

                                }
                                else if(textcodecontroller.text!=order_data["code"]){
                                  getsnackbar("enter correct order code to complete the task");
                                }else{
                                  Get.find<OrderController>().is_correct_code.value=true;
                                }

                              },
                              onSwipeEnd: () {
                                if(Get.find<OrderController>().is_correct_code.value){
                                  // run complet mutation
                                  runMutation({
                                    "id":order_data["id"]
                                  });

                                }
                              },
                              activeTrackColor: Constants.primcolor.withOpacity(0.7),
                              elevationThumb: 10,
                              enabled:true,
                              child: const Text(
                                "Swipe to complete order",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ))


                        );
                      },)

            )
          ],
        ),
      ),
    );
  }
}
