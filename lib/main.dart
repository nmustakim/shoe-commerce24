import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/provider/cart_provider.dart';
import 'package:shoe_commerce/provider/shoes_provider.dart';
import 'package:shoe_commerce/screens/discover_shoes/discover_shoes.dart';
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
              CartProvider())
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
        builder: (_, child) {
          return  MaterialApp(
            
            theme: ThemeData(
            ),
            debugShowCheckedModeBanner: false,
            home: const DiscoverShoes(),
          );
        });
  }
}
