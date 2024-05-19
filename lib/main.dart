import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_commerce/provider/shoes_provider.dart';
import 'package:shoe_commerce/screens/discover_shoes/discover_shoes.dart';
import 'package:shoe_commerce/services/shoe_service.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ShoesProvider(ShoesService(FirebaseFirestore.instance)),
      child: const ShoeCommerce()));
}

class ShoeCommerce extends StatelessWidget {
  const ShoeCommerce({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,

        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DiscoverShoes(),
          );
        });
  }
}
