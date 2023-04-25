import 'package:flutter/material.dart';
import 'gpt.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const FormPage(),
    );
  }
}


// ___________________


// import 'package:provider/provider.dart';

// void main() => runApp(AppState());

// class AppState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [ChangeNotifierProvider(create: (_) => ProductsService())],
//       child: MyApp(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'SusAI App',
//       initialRoute: 'home',
//       routes: {
//         'home': (_) => FormPage(),
//         // 'home'    : ( _ ) => HomeScreen(),
//         // 'product' : ( _ ) => ProductScreen(),
//       },
//     );
//   }
// }
