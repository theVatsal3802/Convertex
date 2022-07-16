import 'dart:convert';

Map<String, String> allCurrenciesFromJson(String str) {
  return Map.from(jsonDecode(str)).map(
    (key, value) => MapEntry<String, String>(key, value),
  );
}

String allCurrenciesToJson(Map<String, String> data) {
  return json.encode(
    Map.from(data).map(
      (key, value) => MapEntry<String, dynamic>(key, value),
    ),
  );
}
