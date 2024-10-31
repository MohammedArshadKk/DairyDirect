import 'package:dairy_direct/controller/add_prodect_controller.dart';
import 'package:dairy_direct/controller/add_salesman_controller.dart';
import 'package:dairy_direct/utils/constants.dart';
import 'package:dairy_direct/view/screens/common/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: Constants.supabaseProjectUrl, anonKey: dotenv.env['SUPABASE_API']!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddSalesmanController()),
        ChangeNotifierProvider(create: (context) => AddProdectController()), 
      ],
      child: GetMaterialApp(
        title: 'DairyDirect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[600]!),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
