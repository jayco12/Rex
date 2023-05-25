import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rex/screens/cart_screen/start_shopping.dart';
import '../../components/utilities/constants.dart';
import '../../components/utilities/submit.dart';
import '../gaz_form.dart';
import 'package:hive/hive.dart';

import 'models/Gaz.dart';

class CartScreen2 extends StatefulWidget {
  CartScreen2({super.key});

  @override
  State<CartScreen2> createState() => _CartScreen2State();
}

totalItems(List<Gaz> data) async {
  if (data.isEmpty) {
    return 0;
  }
  var total = (data.fold<int?>(data.first.price,
      (previousValue, element) => previousValue! + element.price));
  return (total);
}

class _CartScreen2State extends State<CartScreen2> {
  late final Box contactBox;

  _deleteInfo(int index) {
    contactBox.deleteAt(index);
    print('Item deleted from box at index:$index');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactBox = Hive.box('GazBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: contactBox.listenable(),
          builder: (context, Box box, widget) {
            return box.isEmpty
                ? StartShopping()
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
                                                      box.clear();
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
                                  var currentBox = box;
                                  var GazData = currentBox.getAt(index);

                                  return Card(
                                    elevation: 6.0,
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 70,
                                        width: 70,
                                        child: Image.asset(
                                          GazData.image,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      title: Text(GazData.size),
                                      subtitle: Text(
                                          '\n\nquantity:${GazData.quantity}'),
                                      trailing: GestureDetector(
                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _deleteInfo(index);
                                            });
                                          }),
                                    ),
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
                                '${totalItems} CFA',
                                style: kCart4,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 42.5,
                          ),
                          Submit(
                              onPressed: () {},
                              margin: EdgeInsets.only(left: 205.0, right: 10.0),
                              text: 'COMMANDE'),
                          const SizedBox(
                            height: 50.0,
                          )
                        ]));
          }),
    );
  }
}
