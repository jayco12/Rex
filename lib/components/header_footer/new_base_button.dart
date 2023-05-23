import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rex/components/header_footer/base_button.dart';
import 'package:rex/components/header_footer/top_bar.dart';
import 'package:rex/components/utilities/rex_colors.dart';
import 'package:rex/screens/gaz_page.dart';
// import '../../routes/app_router.gr.dart';
import '../../screens/gaz_form.dart';
import '../../screens/home_page.dart';
import '../../screens/user_info.dart';
import '../../screens/cart_screen/start_shopping.dart';
import '../../screens/cart_screen/cart_screen2.dart';
import '../screens template/base.dart';

class BaseBar extends StatefulWidget {
  static const routeName = '/app';

  BaseBar({
    super.key,
  });

  @override
  State<BaseBar> createState() => _BaseBarState();
}

class _BaseBarState extends State<BaseBar> {
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    if (argumentData == null) {
      print('null');
    } else {
      setState(() {
        selectedIndex = argumentData[0]['selectedIndex'];
      });
      print(argumentData[0]['selectedIndex']);
    }
    super.initState();
  }

  int selectedIndex = 0;
  final widgetOptions = [
    const HomePage(),
   const CartScreen2(),
    const UserInfo(),
    const GazPage(
      addAppbar: false,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              fontSize: 10.0,
              color: Colors.amberAccent),
          unselectedLabelStyle: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              fontSize: 0,
              color: Colors.amberAccent),
          elevation: 20,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? Image.asset(
                      'images/homeicon.png',
                      height: 32,
                      width: 32,
                    )
                  : Image.asset(
                      'images/homeicon.png',
                      height: 25,
                      width: 25,
                    ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? Image.asset(
                      'images/carticon.png',
                      height: 32,
                      width: 32,
                    )
                  : Image.asset(
                      'images/carticon.png',
                      height: 25,
                      width: 25,
                    ),
              label: 'cart',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? Image.asset(
                      'images/usericon.png',
                      height: 32,
                      width: 32,
                    )
                  : Image.asset(
                      'images/usericon.png',
                      height: 25,
                      width: 25,
                    ),
              label: 'profile',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 3
                  ? const Icon(
                      Icons.gas_meter_rounded,
                      color: Colors.black,
                      size: 35,
                    )
                  : const Icon(
                      Icons.gas_meter_rounded,
                      color: Colors.black,
                      size: 27,
                    ),
              label: 'gaz',
            ),
          ],
          currentIndex: selectedIndex,
          fixedColor: Colors.transparent,
          onTap: (i) {
            setState(() {
              selectedIndex = i;
            });
          },
        ));
  }
}
