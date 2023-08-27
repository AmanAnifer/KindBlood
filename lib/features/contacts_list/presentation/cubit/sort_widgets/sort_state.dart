part of 'sort_cubit.dart';

class SortState extends SortBy with EquatableMixin {
  SortBy get sortBy => this;

  SortState({
    required super.sortByColumn,
    required super.order,
  });

  factory SortState.fromSortBy(SortBy sortBy) =>
      SortState(sortByColumn: sortBy.sortByColumn, order: sortBy.order);

  @override
  List<Object?> get props => [
        sortByColumn,
        order,
      ];
}
