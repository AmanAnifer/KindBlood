part of 'filter_cubit.dart';

class FilterState extends SearchFilter {
  SearchFilter get searchFilter =>
      this; // Just to make it more explicit that FilterState is actually SearchFilter subclass
  FilterState({
    required super.contactSearchMode,
    required super.bloodGroup,
    required super.userLocation,
    super.maxDistance,
    super.showAnonVolunteers,
  });

  factory FilterState.fromSearchFilter({required SearchFilter searchFilter}) {
    return FilterState(
      contactSearchMode: searchFilter.contactSearchMode,
      bloodGroup: searchFilter.bloodGroup,
      userLocation: searchFilter.userLocation,
      maxDistance: searchFilter.maxDistance,
      showAnonVolunteers: searchFilter.showAnonVolunteers,
    );
  }
}
