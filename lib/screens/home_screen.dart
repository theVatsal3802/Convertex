import 'package:flutter/material.dart';

import '../functions/fetch_data_functions.dart';
import '../models/rates.dart';
import '../widgtes/inr_to_any.dart';
import '../widgtes/any_to_any.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RatesModel> result;
  late Future<Map> allCurrencies;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    result = fetchRates();
    allCurrencies = fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convertex"),
      ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jfif"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: FutureBuilder<RatesModel>(
                future: result,
                builder: (context, rateSnapshot) {
                  if (rateSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary),
                    );
                  }
                  return Center(
                    child: FutureBuilder<Map>(
                      future: allCurrencies,
                      builder: (context, currSnapshot) {
                        if (currSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UsdToAny(
                              currencies: currSnapshot.data!,
                              rates: rateSnapshot.data!.rates,
                            ),
                            AnyToAny(
                              rates: rateSnapshot.data!.rates,
                              currencies: currSnapshot.data!,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
