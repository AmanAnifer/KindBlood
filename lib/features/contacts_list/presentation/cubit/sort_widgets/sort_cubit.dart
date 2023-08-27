import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/features/contacts_list/domain/entities/search_sorting.dart';
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
