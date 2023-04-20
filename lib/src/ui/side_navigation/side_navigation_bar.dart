import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class Test {
  final int index;
  final int index1;

  const Test({
    required this.index,
    required this.index1
  });
}

class A extends Test {

  static const hh = 1;

  A({
    required super.index,
    super.index1 = hh
  });
}

// 대충 CustomView constructor 예시
class MainSideNavigation extends SideNavigationBar {

  static const List<SideNavigationBarItem> _items = [
    SideNavigationBarItem(icon: Icons.dashboard, label: "DashBoard"),
    SideNavigationBarItem(icon: Icons.person, label: "Account"),
    SideNavigationBarItem(icon: Icons.settings, label: "Settings")
  ];

  final SideBarToggler _toggler = const SideBarToggler(
      expandIcon: Icons.keyboard_arrow_left,
      shrinkIcon: Icons.keyboard_arrow_right);

  const MainSideNavigation({
    super.key,
    required super.selectedIndex,
    super.items = _items,
    required super.onTap,
  });
}
