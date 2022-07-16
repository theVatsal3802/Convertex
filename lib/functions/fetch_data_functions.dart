import 'package:convertex/models/all_currencies.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/rates.dart';

String apiKey = dotenv.get("API_KEY", fallback: "");

Future<Map> fetchCurrencies() async {
  final url = Uri.parse(
      "https://openexchangerates.org/api/currencies.json?app_id=$apiKey");
  final response = await http.get(url);
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

Future<RatesModel> fetchRates() async {
  final url =
      Uri.parse("https://openexchangerates.org/api/latest.json?app_id=$apiKey");
  final response = await http.get(url);
  final result = ratesModelFromJson(response.body);
  return result;
}

String convertINR(Map exchangeRates, String amount, String currency) {
  String usd = inrToUsd(exchangeRates, amount, "INR", currency);
  var output =
      ((double.tryParse(usd)! * exchangeRates[currency]).toStringAsFixed(4))
          .toString();
  return output;
}

String convertAny(Map exchangeRates, String amount, String baseCurrency,
    String finalCurrency) {
  var output = ((double.tryParse(amount)! / exchangeRates[baseCurrency]) *
          exchangeRates[finalCurrency])
      .toStringAsFixed(4)
      .toString();
  return output;
}

String inrToUsd(Map exchangeRates, String amount, String baseCurrency,
    String finalCurrency) {
  var output = ((double.tryParse(amount)! / exchangeRates[baseCurrency]) *
          exchangeRates[finalCurrency])
      .toStringAsFixed(4)
      .toString();
  return output;
}
