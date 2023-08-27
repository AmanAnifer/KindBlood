enum SortByColumn { distance, bloodGroup }

enum Order { best, worst }

class SortBy {
  final SortByColumn sortByColumn;
  final Order order;
  SortBy({
    this.sortByColumn = SortByColumn.distance,
    this.order = Order.best,
  });
}
