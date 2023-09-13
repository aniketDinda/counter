// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:counter/constants/constants.dart';
import 'package:counter/provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  void authUser() async {
    final store = GetStorage();
    String deviceId = '';
    try {
      deviceId = store.read(Constants.DEVICE_ID) ?? '';
    } catch (e) {
      return;
    }
    if (deviceId.isEmpty) {
      Uuid uuid = const Uuid();
      deviceId = uuid.v1();
      await store.write(Constants.DEVICE_ID, deviceId);
      await store.write(Constants.COUNTER_VALUE, '0');
    }

    final counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      counterProvider.initialize();
    });
  }

  @override
  void initState() {
    super.initState();

    authUser();
    GetStorage().listenKey(Constants.COUNTER_VALUE, (value) {
      updateCounterValue();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateCounterValue() async {
    final counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    counterProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDF6E9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFDF6E9),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(
              builder: (context, value, child) {
                return Text(
                  'Value: ${value.value.toString()}',
                  style: const TextStyle(
                    fontSize: 50.0,
                    color: Colors.black,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 100,
            ),
            Consumer<CounterProvider>(
              builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        value.decrease();
                      },
                      backgroundColor: Colors.black,
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        value.reset();
                      },
                      backgroundColor: Colors.black,
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        value.increase();
                      },
                      backgroundColor: Colors.black,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
