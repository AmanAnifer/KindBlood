part of 'routes.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  static const tabs = [
    CustomBottomNavigationBarItem(
      initialLocation: Routes.listingScreen,
      icon: Icon(Icons.contacts),
      label: "Contacts",
    ),
    CustomBottomNavigationBarItem(
      initialLocation: Routes.settingsScreen,
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    int index = 0;
    for (var tab in tabs) {
      if (location.startsWith(tab.initialLocation)) {
        index = tabs.indexOf(tab);
      }
    }
    // final index = tabs.indexWhere(
    //   (t) {
    //     return location.startsWith(t.initialLocation);
    //   },
    // );
    // if index not found (-1), return 0
    return index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: tabs,
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  const CustomBottomNavigationBarItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
