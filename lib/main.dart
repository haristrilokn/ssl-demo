import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssl_demo/src/home_page.dart';
import 'package:ssl_demo/src/home_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSL Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
          create: (context) => HomeProvider(), child: const HomePage()),
    );
  }
}
