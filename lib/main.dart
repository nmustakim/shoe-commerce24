import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/providers/cart_provider.dart';
import 'package:shoe_commerce/providers/filter_selection_provider.dart';
import 'package:shoe_commerce/providers/order_provider.dart';
import 'package:shoe_commerce/providers/review_provider.dart';
import 'package:shoe_commerce/providers/shoes_provider.dart';
import 'package:shoe_commerce/routes.dart';
import 'package:shoe_commerce/services/navigation_service.dart';
import 'package:shoe_commerce/services/shoe_service.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(
          create: (BuildContext context) =>
              ShoesProvider(ShoesService(FirebaseFirestore.instance))),
      ChangeNotifierProvider(
          create: (BuildContext context) =>
              CartProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) =>
                OrderProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) =>
                ReviewProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) =>
                FilterProvider())
    ],
      child: const ShoeCommerce()),
  );

}

class ShoeCommerce extends StatelessWidget {
  const ShoeCommerce({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 872),
        minTextAdapt: true,
        builder: (context, child) {
          return  MaterialApp(

            navigatorKey: NavigationService.navigatorKey,
            initialRoute: AppRoutes.discoverShoes,
            routes: AppRoutes.generateRoutes,
            theme: ThemeData(
            ),
            debugShowCheckedModeBanner: false,

          );
        });
  }
}
