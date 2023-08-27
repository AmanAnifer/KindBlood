import 'package:flutter/material.dart';
import 'package:conditional_parent_widget/conditional_parent_widget.dart';

class FilterWidgets extends StatelessWidget {
  const FilterWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConditionalParentWidget(
      condition: true,
      parentBuilder: (child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            children: child,
          ),
        );
      },
      parentBuilderElse: (child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: addSpacingBetween(child),
          ),
        );
      },
      child: [
        // const TenWidthBox(),
        ActionChip(
          onPressed: () {},
          label: Text("Blood Type: AB+ve"),
        ),
        // const TenWidthBox(),
        ActionChip(
          onPressed: () {},
          label: Text("Mode: Offline"),
        ),
        // const TenWidthBox(),
        ActionChip(
          label: Text("Anonymous volunteers"),
        ),
        // const TenWidthBox(),
        ActionChip(
          label: Text("Within 1 km"),
        ),
        // const TenWidthBox(),
        ChoiceChip(
          onSelected: (selected) {},
          selected: true,
          label: Text("Can donate"),
        ),
      ],
    );
  }
}

List<Widget> addSpacingBetween(List<Widget> children) {
  /* 
  When showing the chips in SingleChildScrollView and Row, the Row's 
  mainAxisAlignment.spaceBetween doesn't work since it has no width constraints,
  so instead, add SizedBox between elements
  */
  List<Widget> spacedElements = [];
  for (var e in children) {
    spacedElements.add(e);
    spacedElements.add(
      const SizedBox(
        width: 10,
      ),
    );
  }
  spacedElements.removeLast();
  return spacedElements;
}
