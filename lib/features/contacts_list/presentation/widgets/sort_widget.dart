import 'package:flutter/material.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood/features/contacts_list/presentation/cubit/sort_widgets/sort_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).focusColor,

      leading: SizedBox(
        width: 60,
        child: InkWell(
          // splashColor: Colors.transparent,
          // hoverColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          // focusColor: Colors.transparent,
          onTap: () {
            context.read<SortCubit>().updateSortOptions(
                newSortBy: SortBy(sortByColumn: SortByColumn.distance));
          },
          child: Text(
            "Distance",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
      title: InkWell(
        // onTap: () {},
        // splashColor: Colors.transparent,
        // hoverColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        // focusColor: Colors.transparent,
        child: Text(
          "Contact",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      trailing: InkWell(
        onTap: () {
          context.read<SortCubit>().updateSortOptions(
              newSortBy: SortBy(sortByColumn: SortByColumn.bloodGroup));
        },
        // splashColor: Colors.transparent,
        // hoverColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        // focusColor: Colors.transparent,
        child: Text(
          "Blood Group",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),

      // onPressed: () {},
      // child:
      // ),
      // TextButton(
      //   onPressed: () {},
      //   child:
      // ),
      // TextButton(
      //   onPressed: () {},
      //   child:
      // ),
    );
  }
}
