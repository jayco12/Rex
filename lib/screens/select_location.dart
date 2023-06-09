import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rex/components/utilities/submit.dart';
import 'package:rex/services/hive_storage_service.dart';

import '../components/header_footer/top_bar.dart';
import '../components/utilities/constants.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  State<SelectLocation> createState() => SelectLocationState();
}

class SelectLocationState extends State<SelectLocation> {
  final searchCtl = TextEditingController();
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: SizedBox(
                    width: 300.0,
                    height: 30.0,
                    child: CupertinoSearchTextField(
                      controller: searchCtl,
                      placeholder: 'Rechercher ou entrer votre adresse',
                      style: kUserInfoHolder,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Placeholder(
                  color: Colors.green,
                  fallbackHeight: 414.0,
                  fallbackWidth: 320.0,
                ),
                const SizedBox(
                  height: 96.0,
                ),
                 Submit(
                  onPressed: () {
                    
                    HiveHelper().saveLocation(searchCtl.text);
                    setState(() {
                      
                    });
                  },
                  margin:const EdgeInsets.only(left: 116.0, right: 116.0),
                  text: 'AJOUTEZ L\'ADRESSE',
                ),
                const SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
