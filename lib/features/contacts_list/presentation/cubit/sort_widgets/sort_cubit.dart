import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood_common/core_entities.dart';

import 'package:equatable/equatable.dart';
part 'sort_state.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit()
      : super(
          SortState(
            sortByColumn: SortByColumn.distance,
            order: Order.best,
          ),
        );
  void updateSortOptions({required SortBy newSortBy}) {
    emit(SortState.fromSortBy(newSortBy));
  }
}
