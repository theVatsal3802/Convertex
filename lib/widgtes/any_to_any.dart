import 'package:flutter/material.dart';

import '../helpers/blank_space_widgets.dart';
import '../functions/fetch_data_functions.dart';

class AnyToAny extends StatefulWidget {
  final Map<String, dynamic> rates;
  final Map<dynamic, dynamic> currencies;
  const AnyToAny({required this.rates, required this.currencies, Key? key})
      : super(key: key);

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  final amountController = TextEditingController();

  String dropDownValue1 = "USD";
  String dropDownValue2 = "INR";
  String answer = "Converted Currency will be displayed here";

  bool validAmount() {
    if (amountController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void calculateConversion() {
    bool validity = validAmount();
    if (!validity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: const Text("Please Enter some amount first."),
          action: SnackBarAction(
            textColor: Theme.of(context).colorScheme.onError,
            label: "OK",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      return;
    }
    setState(() {
      answer = "${amountController.text} $dropDownValue1 = ${convertAny(
        widget.rates,
        amountController.text,
        dropDownValue1,
        dropDownValue2,
      )} $dropDownValue2";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Convert Any Currency",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VerticalSizedBox(
              height: 20,
            ),
            TextFormField(
              key: const ValueKey("amount"),
              controller: amountController,
              decoration: InputDecoration(
                hintText: "Enter Amount",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const VerticalSizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: dropDownValue1,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade700,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropDownValue1 = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>(
                      (value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text("TO"),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: dropDownValue2,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade700,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropDownValue2 = newValue!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>(
                      (value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            Center(
              child: IconButton(
                tooltip: "Interchange Currency units",
                onPressed: () {
                  String interchange = dropDownValue1;
                  dropDownValue1 = dropDownValue2;
                  dropDownValue2 = interchange;
                  setState(() {});
                },
                icon: const Icon(Icons.swap_horiz),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: calculateConversion,
                  child: const Text("CONVERT"),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: () {
                    setState(() {
                      amountController.text = "";
                      answer = "Converted Currency will be displayed here";
                    });
                  },
                  child: const Text("RESET FIELDS"),
                ),
              ],
            ),
            const VerticalSizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                answer,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
