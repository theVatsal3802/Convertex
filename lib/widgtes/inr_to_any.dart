import 'package:flutter/material.dart';

import '../helpers/blank_space_widgets.dart';
import '../functions/fetch_data_functions.dart';

class UsdToAny extends StatefulWidget {
  final Map<dynamic, dynamic> currencies;
  final Map<String, double> rates;
  const UsdToAny({required this.currencies, required this.rates, Key? key})
      : super(key: key);

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  final inrController = TextEditingController();
  String dropDownValue = "USD";
  String answer = "Converted Currency will be displayed here";

  void calculateConversion() {
    if (inrController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: const Text("Please Enter some amount first."),
          action: SnackBarAction(
            label: "OK",
            textColor: Theme.of(context).colorScheme.onError,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      return;
    }
    setState(() {
      answer = "${inrController.text} INR = ${convertINR(
        widget.rates,
        inrController.text,
        dropDownValue,
      )} $dropDownValue";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "INR to any Currency",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const VerticalSizedBox(
              height: 20,
            ),
            TextFormField(
              key: const ValueKey("inr"),
              controller: inrController,
              decoration: const InputDecoration(
                hintText: "Enter INR",
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
                    value: dropDownValue,
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
                        dropDownValue = newValue!;
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
                const HorizontalSizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: calculateConversion,
                  child: const Text("CONVERT"),
                ),
                const HorizontalSizedBox(
                  width: 10,
                ),
              ],
            ),
            const VerticalSizedBox(
              height: 10,
            ),
            Text(answer),
            const VerticalSizedBox(
              height: 10,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                setState(() {
                  inrController.text = "";
                  answer = "Converted Currency will be displayed here";
                });
              },
              child: const Text("RESET FIELDS"),
            ),
          ],
        ),
      ),
    );
  }
}
