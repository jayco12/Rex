import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rex/components/utilities/back_arrow.dart';
import 'package:rex/components/utilities/choice_text.dart';
import 'package:rex/components/utilities/constants.dart';
import 'package:rex/components/utilities/submit.dart';
import 'package:rex/components/screens template/gas_form_field.dart';
import 'package:rex/components/header_footer/top_bar.dart';
import 'package:rex/components/screens template/gas_form_text.dart';
import 'package:rex/components/utilities/floating_button.dart';
import 'package:rex/components/utilities/gaz_class.dart';
import 'package:provider/provider.dart';

import '../services/firebase_functions.dart';
import 'cart_screen/cart_data.dart';
import 'cart_screen/cart_list.dart';

class GazForm extends StatefulWidget {
  GazForm({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<GazForm> createState() => _GazFormState();
}

class _GazFormState extends State<GazForm> {
  late String image;
  String dropdownValue = '6KG';
  DropdownButton<String> dropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String kg in gasKg) {
      var newMenu = DropdownMenuItem(
        value: kg,
        child: Text(
          kg,
          style: GoogleFonts.roboto(
            textStyle: kFormStyleRoboto,
          ),
        ),
      );

      dropDownItems.add(newMenu);
    }

    return DropdownButton<String>(
        value: dropdownValue,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            dropdownValue = value.toString();
            seekKg();
          });
        });
  }

  Map<String, String> gasValues = {};

  void seekKg() {
    try {
      var gas = GazClass().getKg(dropdownValue);
      setState(() {
        gasValues = gas;
      });
    } catch (e) {
      //print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    seekKg();
  }

  int getPrice() {
    List<Gas> gazPrice = [];
    for (String amount in gasPrice) {
      //print(amount);
      if (dropdownValue == gasKg[0]) {
        var gasOne = int.parse(gasPrice[0]) * quantite;
        print(gasOne);
        return gasOne;
      } else if (dropdownValue == gasKg[1]) {
        var gasTwo = int.parse(gasPrice[1]) * quantite;
        print(gasTwo);
        return gasTwo;
      }
      gazPrice.add(
        Gas(
          dropdownValue: dropdownValue,
          value: gasValues[amount].toString(),
        ),
      );
    }
    return getPrice();
  }

  late int quantite = 1;

  final _formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final dropdownController = TextEditingController();
  final qualityController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: TopBar(
          phonenavigator: InkResponse(
            onTap: () {
              context.router.pushNamed('/our-contact');
            },
            child: const Icon(Icons.phone),
          ),
          infonavigator: InkResponse(
            onTap: () {
              //widget.infonavigator;
            },
            child: const Icon(Icons.info_outline_rounded),
          ),
          aboutnavigator: InkResponse(
            onTap: () {
              context.router.pushNamed('/about-us');
            },
            child: const Icon(Icons.group_rounded),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          FloatingButton(
            button: Image.asset('images/Salon.png'),
            onTap: () {
              context.router.replaceNamed('/salon-page');
            },
          ),
          const BackArrow(),
          const ChoiceText(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                width: 16.0,
              ),
              Image.asset(
                widget.image,
                gaplessPlayback: true,
                width: 85.5,
                height: 106.35,
              ),
              const SizedBox(
                width: 9.5,
              ),
              Card(
                elevation: 4.0,
                child: Container(
                  decoration: kGasFormDecoration,
                  width: 200.0,
                  height: 334.0,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const GasFormText(
                        margin: EdgeInsets.only(left: 20.0, top: 25.0),
                        text: 'Taille',
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 80.0),
                        child: dropDown(),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const GasFormText(
                          margin: EdgeInsets.only(
                            left: 20.0,
                          ),
                          text: 'Quantite'),
                      GazFormField(
                        controller: qualityController,
                        onChanged: (_) {
                          setState(() {
                            quantite = int.parse(qualityController.text);
                          });
                          print(quantite);
                        },
                        margin: const EdgeInsets.only(
                          left: 20.0,
                          right: 80.0,
                        ),
                        enabled: true,
                        text: '1',
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const GasFormText(
                        margin: EdgeInsets.only(
                          left: 20.0,
                        ),
                        text: 'Prix',
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            maximumSize: const Size.fromWidth(65),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: SizedBox(
                          height: 30,
                          width: 150,
                          child: Center(
                            child: GasFormText(
                              controller: priceController,
                              text: (getPrice()).toString(),
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 44.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Submit(
                          onPressed: () async {
                            setState(() {
                              datalist.add(Gaz(
                                  image: widget.image,
                                  size: dropdownValue,
                                  quantity: quantite.toString(),
                                  price: getPrice()));
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return const AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                      size: 100,
                                    ),
                                  );
                                });
                            priceController.clear();
                            qualityController.clear();
                          },
                          margin:
                              const EdgeInsets.only(left: 19.0, right: 41.1),
                          text: 'AJOUTER AU PANIER'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 30.0,
              ),
            ]),
          ),
          const SizedBox(
            width: 69.0,
          ),
        ]
            // }
            ),
      ),
    );
  }
}

class Gaz {
  final image;
  final size;
  final String quantity;
  final int price;

  Gaz(
      {required this.image,
      required this.size,
      required this.quantity,
      required this.price});
}

List<Gaz> datalist = [];

class Gas extends StatelessWidget {
  const Gas({
    Key? key,
    required this.dropdownValue,
    required this.value,
  }) : super(key: key);

  final String dropdownValue;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
