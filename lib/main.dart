import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:rex/routes/app_router.gr.dart';

import 'screens/cart_screen/models/Gaz.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(GazAdapter());
  // Opening the box
  await Hive.openBox('GazBox');

  runApp(
    Rex(),
  );
}

class Rex extends StatelessWidget {
  Rex({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rex',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );

    // MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Rex',
    //   home: SplashView(),
    // );
  }
}
