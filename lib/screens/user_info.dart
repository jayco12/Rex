import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rex/components/utilities/constants.dart';
import 'package:rex/components/utilities/submit.dart';
import 'package:rex/components/screens template/user.dart';
import 'package:rex/services/hive_storage_service.dart';

import 'select_location.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50.0,
        ),
        Container(
          margin: const EdgeInsets.only(left: 45.0, right: 45.0),
          height: 40.0,
          child: Text(
            'Information Utilisateur',
            style: GoogleFonts.poppins(
              textStyle: kInformationUtilisateur,
            ),
          ),
        ),
        const SizedBox(
          height: 45.0,
        ),
        Expanded(
          child: ListView(
            children: [
              const User(
                  image: 'images/abouticon.png', placeholder: 'Caleb Peter'),
              const SizedBox(
                height: 29.0,
              ),
              const User(
                  image: 'images/telephone.png', placeholder: '+227 01234567'),
              const SizedBox(
                height: 26.0,
              ),
              User(
                image: 'images/locationicon.png',
                placeholder: locationBox?.get('location').toString() ??
                    'Adresse de livraison',
                onTap: () {
                  context.router.pushNamed('/select-location');
                },
              ),
              const SizedBox(
                height: 45.5,
              ),
              const Submit(
                  margin: EdgeInsets.only(left: 116.0, right: 116.0),
                  text: 'SAUVEGARDER'),
            ],
          ),
        ),
      ],
    );
    // bottomNavigationBar: const BaseButton(),
  }
}
