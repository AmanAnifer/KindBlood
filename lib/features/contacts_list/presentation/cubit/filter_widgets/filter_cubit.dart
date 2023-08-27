import '../../../../../core/entities/length_units.dart';
import '../../../domain/entities/search_filters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/myinfo_entity.dart';

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
}
