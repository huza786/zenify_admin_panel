import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/firebase_options.dart';
import 'package:zenify_admin_panel/firebase_services/firebase_product_provider.dart';
import 'package:zenify_admin_panel/models/product_model.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/admin_screen.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/navigation_rail_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //stream provider provides data inside app at the root widget level
        //and help to manage data easily through app
        //the below code provides a list of products from  firebase using stream builder
        StreamProvider<List<Product>>.value(
            value: FirebaseFirestore.instance
                .collection('Products')
                .snapshots()
                .map(
                  (snapshot) => snapshot.docs
                      .map(
                        (doc) => Product.fromMap(
                          doc.data(),
                        ),
                      )
                      .toList(),
                ),
            initialData: const []),
        ChangeNotifierProvider(
          //navigation rail provider
          create: (context) => NavigationRailProvider(),
        ),
        ChangeNotifierProvider(
          //navigation rail provider
          create: (context) => FirebaseProductProvider(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            navigationRailTheme: NavigationRailThemeData(
                backgroundColor: MyAppColors.darkBlue,
                selectedIconTheme:
                    IconThemeData(color: MyAppColors.primaryred)),
            drawerTheme: const DrawerThemeData(
              backgroundColor: MyAppColors.primaryred,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: MyAppColors.primaryred,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Metropolis',
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
              centerTitle: true,
            ),
            fontFamily: 'Metropolis',
            primaryColor: MyAppColors.primaryred,
            brightness: Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          home: const AdminScreen()),
    );
  }
}

class MyAppColors {
  static const darkBlue = Color(0xFF1E1E2C);
  static const primaryred = Color(0xFFDB3022);
}
