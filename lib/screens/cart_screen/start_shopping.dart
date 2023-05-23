import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rex/screens/gaz_page.dart';

import '../../components/utilities/constants.dart';
import '../../components/utilities/submit.dart';
import '../../routes/app_router.gr.dart';

class StartShopping extends StatefulWidget {
  const StartShopping({Key? key}) : super(key: key);

  @override
  State<StartShopping> createState() => _StartShoppingState();
}

class _StartShoppingState extends State<StartShopping> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50.0,
        ),
        const Text(
          'PANIER',
          style: kLeadText,
        ),
        Image.asset(
          'images/cartimages/cart_empty.png',
          height: 260.0,
        ),
        const Text(
          'Oups, votre panier est vide !',
          style: kCart0,
        ),
        Center(
          child: Container(
              margin: const EdgeInsets.only(left: 65.0, right: 65.0),
              height: 50.0,
              child: const Text(
                'Il semble qu\'il n\'y ait rien ici, explorez et présélectionnez certains éléments',
                style: kSubHeadings,
                // maxLines: 3,
                // textDirection: TextDirection.rtl,
                // textAlign: TextAlign.left,
              )),
        ),
        const Submit(
          margin: EdgeInsets.only(left: 111.0, right: 111.0),
          text: 'Commencer à magasiner',
        ),
      ],
    );
  }
}
