import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rex/components/utilities/choice_text.dart';
import 'package:rex/components/utilities/constants.dart';
import 'package:rex/components/utilities/submit.dart';
import 'package:rex/components/screens template/gas_form_field.dart';
import 'package:rex/components/screens template/gas_form_text.dart';
import 'package:rex/components/utilities/floating_button.dart';
import 'package:rex/components/utilities/gaz_class.dart';
import 'package:rex/services/hive_storage_service.dart';
import '../components/utilities/rex_colors.dart';
import 'cart_screen/models/Gaz.dart';

class GazForm extends StatefulWidget {
  GazForm({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<GazForm> createState() => _GazFormState();
}

class _GazFormState extends State<GazForm> {
      final HiveHelper _hiveHelper = HiveHelper();

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
  late int price = 3500;
  final _formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final dropdownController = TextEditingController();
  final qualityController = TextEditingController();
  final priceController = TextEditingController();

  _addInfo() async {
    Gaz newGaz = Gaz(
        image: widget.image,
        size: dropdownValue,
        quantity: quantite.toString(),
        price: getPrice());
  gazBox.add(newGaz);
    print('Info added to box!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          FloatingButton(
            button: Image.asset('images/Salon.png'),
            onTap: () {
              context.router.replaceNamed('/salon-page');
            },
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 36.77,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkResponse(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.leftLong,
                    color: RexColors.textColor,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
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
                      GasFormText(
                        margin: EdgeInsets.only(left: 20.0, top: 25.0),
                        text: 'Taille',
                        enabled: false,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 80.0),
                        child: dropDown(),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      GasFormText(
                        margin: EdgeInsets.only(
                          left: 20.0,
                        ),
                        text: 'Quantite',
                        enabled: false,
                      ),
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
                      GasFormText(
                        margin: EdgeInsets.only(
                          left: 20.0,
                        ),
                        text: 'Prix',
                        enabled: false,
                      ),
                      GasFormText(
                        controller: priceController,
                        text: (getPrice()).toString(),
                        onChanged: (_) {
                          setState(() {
                            price = int.parse(priceController.text);
                          });
                          print(price);
                        },
                        margin: const EdgeInsets.only(left: 20.0, right: 44.0),
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Submit(
                          onPressed: () async {
                            setState(() {
                              _addInfo();
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  // Future.delayed(const Duration(seconds: 1),
                                  //     () {
                                  //   Navigator.of(context).pop(true);
                                  // });
                                  return AlertDialog(
                                    content: const Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.green,
                                      size: 100,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            context.router.pop();
                                          },
                                          child: Text('Done'))
                                    ],
                                  );
                                });
                            priceController.clear();
                            qualityController.clear();
                          },
                          margin:
                              const EdgeInsets.only(left: 19.0, right: 31.1),
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
