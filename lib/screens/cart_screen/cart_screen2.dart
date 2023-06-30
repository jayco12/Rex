// ignore_for_file: unused_local_variable, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rex/screens/cart_screen/start_shopping.dart';
import 'package:rex/services/hive_storage_service.dart';
import '../../components/utilities/constants.dart';
import '../../components/utilities/submit.dart';
import '../bag.dart';
import 'package:hive/hive.dart';

import 'models/Gaz.dart';
// import 'google_sign_in.dart';

class CartScreen2 extends StatefulWidget {
  const CartScreen2({super.key});

  @override
  State<CartScreen2> createState() => _CartScreen2State();
}

class _CartScreen2State extends State<CartScreen2> {
  final HiveHelper _hiveHelper = HiveHelper();

  // late final Box contactBox;

  @override
  void initState() {
    super.initState();
    // contactBox = Hive.box('GazBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: gazBox.listenable(),
          builder: (context, Box box, widget) {
            return box.isEmpty
                ? const StartShopping()
                : Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'PANIER',
                                style: kLeadText,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: const Text('Warning'),
                                            content: const Text('Clear Cart'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    context.router.pop();
                                                  },
                                                  child: const Text(
                                                    'cancel',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _hiveHelper.deleteAll();
                                                    });
                                                    context.router.pop();
                                                  },
                                                  child: const Text(
                                                    'delete',
                                                  ))
                                            ],
                                          ));
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                          Text(
                            '${box.length} élément', //${Provider.of<CartData>(context).cartCount}
                            style: kCart1,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: box.length,
                                itemBuilder: (context, index) {
                                  var gazData = gazBox.getAt(index);

                                  return Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        elevation: 6.0,
                                        child: ListTile(
                                          leading: SizedBox(
                                              height: 70,
                                              width: 70,
                                              child:
                                                  Image.asset(gazData!.image)),
                                          title: Text(gazData.price.toString()),
                                          subtitle: Text(
                                              '\n\nquantity:${gazData.quantity}'),
                                          trailing: GestureDetector(
                                              child: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _hiveHelper.deleteInfo(index);
                                                });
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                'TOTAL',
                                style: kCart4,
                              ),
                              const SizedBox(
                                width: 150.0,
                              ),
                              Text(
                                '${_hiveHelper.totalItems()} CFA',
                                style: kCart4,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 42.5,
                          ),
                          Submit(
                              onPressed: () => _sendMail(context),
                              margin: const EdgeInsets.only(
                                  left: 205.0, right: 10.0),
                              text: 'COMMANDE'),
                          const SizedBox(
                            height: 50.0,
                          )
                        ]));
          }),
    );
  }

  _sendMail(BuildContext context) async {
    // final user = await GoogleAuthApi.signIn();
    // if (user == null) return;
    String? email = 'jessedan160@gmail.com';
    const serviceId = 'service_zq9qmpf';
    const templateId = 'template_d3jwecj';
    Map<String, dynamic> data =
        cartItemsToList(_hiveHelper.getDataList(), email: email, sender: 'Rex');

    final response = await EmailJS.send(
            'service_hfq7jdm',
            'template_k1dkkli',
            data,
            const Options(
                publicKey: 'A5-5H3clIup8fX6Yy',
                privateKey: 'vZwdwYKPBO2e_OQThS'))
        .then((value) {
      log('Sent Data $data');
      log('Sent Response $value');
      log('Sent Response text ${value.text}');
    }).catchError((error) {
      log('Sending Error: $error');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      response == 200
          ? const SnackBar(
              content: Text('order Sent!'), backgroundColor: Colors.green)
          : const SnackBar(
              content: Text('Failed to place order!'),
              backgroundColor: Colors.red),
    );
  }
}

Map<String, dynamic> cartItemsToList(List<Gaz> cartItems, {email, sender}) {
  List<Map<String, dynamic>> cartData =
      cartItems.map((item) => item.toMap()).toList();

  Map<String, dynamic> templateParams = TemplateParams(
    fromName: sender,
    fromEmail: email,
    cartData: cartData,
  ).toMap();
  return templateParams;
}

// Future sendEmail({required List<Gaz> gazes}) async {
//   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//   const serviceId = 'service_zq9qmpf';
//   const templateId = 'template_d3jwecj';

//   final user = await GoogleAuthApi.signIn();
//   if (user == null) return;

//   final email = user.email;
//   // Options(publicKey: '2dBM08mwa_REgPW42', privateKey: '-kEgRjqg-MFVNEbr__ftg');
//   var body = EmailSenderModel(
//           serviceId: serviceId,
//           templateId: templateId,
//           templateParams: TemplateParams(
//             fromName: "Rex",
//             fromEmail: email,
//             total: '',
//             image: '',
//             size: '',
//             quantity: '',
//             price: '',
//           ),
//           gases: gazes)
//       .toJson();
//   Map<String, String>? headers = {
//     'Content-Type': 'application/json',
//     'origin': 'http://localhost'
//   };

//   final response = await http.post(url, headers: headers, body: body);

//   if (kDebugMode) {
//     log(response.body);
//     log(response.request!.url.toString());
//     log(response.statusCode.toString());
//     log(body);
//   }

//   return response.statusCode;
// }
