import 'package:kindblood_common/core_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final MyInfo myInfo;
  FilterCubit({required this.myInfo})
      : super(
          FilterState(
            contactSearchMode: ContactSearchMode.offline,
            bloodGroup: myInfo.bloodGroup,
            userLocation: myInfo.locationCoordinates,
            maxDistance: const InfiniteMeter(),
          ),
        );

  void updateFilters({required SearchFilter newFilter}) {
    emit(FilterState.fromSearchFilter(searchFilter: newFilter));
  }

  void updateFiltersWithNewMyInfo({required MyInfo myInfo}) {
    emit(FilterState(
      contactSearchMode: state.contactSearchMode,
      bloodGroup: myInfo.bloodGroup,
      userLocation: myInfo.locationCoordinates,
      maxDistance: state.maxDistance,
      showAnonVolunteers: state.showAnonVolunteers,
    ));
  }
}
