import 'package:counter/provider.dart';
import 'package:counter/ui/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

//Main file

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Future<void> initialiseApp() async {
    await GetStorage.init();
  }

  @override
  void initState() {
    super.initState();
    // initialiseApp();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'P-NUT Counter',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const CounterApp(),
      ),
    );
  }
}
