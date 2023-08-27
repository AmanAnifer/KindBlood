import 'package:kindblood/features/contacts_list/domain/entities/search_filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindblood/core/entities/myinfo_entity.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final MyInfo myInfo;
  FilterCubit({required this.myInfo})
      : super(
          FilterState(
            contactSearchMode: ContactSearchMode.offline,
            bloodGroup: myInfo.bloodGroup,
          ),
        );

  void updateFilters({required SearchFilter newFilter}) {
    emit(FilterState.fromSearchFilter(searchFilter: newFilter));
  }
}
