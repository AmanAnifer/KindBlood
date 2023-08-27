import 'package:flutter/material.dart';

import 'package:kindblood_common/core_entities.dart';
import 'fixed_slider.dart';

Future<LengthUnit?> showDistanceLimitSelectorDialog(
    {required BuildContext context, LengthUnit? previousDistanceLimit}) async {
  // var textController = TextEditingController(text: "");
  LengthUnit? selectedDistanceLimit = previousDistanceLimit;
  return await showDialog<LengthUnit>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          contentPadding: const EdgeInsets.all(8),
          title: const Text("Select distance limit"),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: FixedValuesSlider(
                    // displayStringBuilder: (length) {
                    //   return length.toString();
                    // },
                    initialValue: previousDistanceLimit,
                    onChanged: (value) {
                      selectedDistanceLimit = value;
                      // textController.text = value.toString();
                    },
                    fixedValues: <LengthUnit>[
                      ...List.generate(
                        9,
                        (index) => Meter(value: 100 + index * 100),
                      ),
                      ...List.generate(
                        19,
                        (index) => KiloMeter(value: 1 + index * 1),
                      ),
                      ...List.generate(
                        7,
                        (index) => KiloMeter(value: 20 + index * 5),
                      ),
                      ...List.generate(
                        5,
                        (index) => KiloMeter(value: 60 + index * 10),
                      ),
                      const InfiniteMeter(),
                      // ...List.generate(
                      //   50,
                      //   (index) => index - 100,
                      // ),
                      // FlutterSliderFixedValue(percent: 100, value: "100km+")
                      // FlutterSliderFixedValue(percent: 30, value: 100),
                      // FlutterSliderFixedValue(percent: 40, value: 1000),
                      // FlutterSliderFixedValue(percent: 60, value: 10000),
                      // FlutterSliderFixedValue(percent: 100, value: 100000),
                    ],
                  ),
                ),

                // Slider(
                //   divisions: 20,
                //   value: actualValue,
                //   min: 0,
                //   max: 1000,
                //   onChanged: (value) {
                //     textController.text = actualValue.toString();
                //     setState(
                //       () {
                //         actualValue = value;
                //       },
                //     );
                //   },
                // ),
                // SizedBox(
                //   width: 90,
                //   child: TextField(
                //     // maxLength: 6,

                //     controller: textController,
                //     decoration: const InputDecoration(
                //       // isCollapsed: true,
                //       border: OutlineInputBorder(),
                //       isDense: true,
                //     ),
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleDialogOption(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                SimpleDialogOption(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, selectedDistanceLimit);
                    },
                    child: const Text("Ok"),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
