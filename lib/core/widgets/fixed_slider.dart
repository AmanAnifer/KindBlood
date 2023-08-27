import 'package:flutter/material.dart';

class FixedValuesSlider<T> extends StatefulWidget {
  final List<T> fixedValues;
  late final String Function(T selectedFixedValue)? displayStringBuilder;
  final void Function(T value)? onChanged;
  final T? initialValue;
  FixedValuesSlider({
    super.key,
    required this.fixedValues,
    this.initialValue,
    String Function(T selectedFixedValue)? displayStringBuilder,
    this.onChanged,
  }) {
    assert(fixedValues.isNotEmpty, "fixedValues should not be empty.");
    this.displayStringBuilder = displayStringBuilder ??
        (T selectedFixedValue) => selectedFixedValue.toString();
  }

  @override
  State<FixedValuesSlider<T>> createState() => _FixedValuesSliderState();
}

class _FixedValuesSliderState<T> extends State<FixedValuesSlider<T>> {
  double value = 0;
  late T selectedFixedValue;

  @override
  void initState() {
    super.initState();
    final initialValue = widget.initialValue;
    if (initialValue != null && widget.fixedValues.contains(initialValue)) {
      selectedFixedValue = initialValue;
    } else {
      selectedFixedValue = widget.fixedValues[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.fixedValues.indexOf(selectedFixedValue).toDouble(),
      min: 0,
      max: widget.fixedValues.length.toDouble() - 1,
      divisions: widget.fixedValues.length - 1,
      label: widget.displayStringBuilder!(
        selectedFixedValue,
      ),
      onChanged: (value) {
        setState(
          () {
            this.value = value;
            selectedFixedValue = widget.fixedValues[value.round()];
          },
        );
        if (widget.onChanged != null) {
          widget.onChanged!(selectedFixedValue);
        }
      },
    );
  }
}
