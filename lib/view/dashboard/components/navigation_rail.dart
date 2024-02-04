import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/view/dashboard/components/navigation_rail_providers.dart';

class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({super.key});

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  @override
  Widget build(BuildContext context) {
    final navRailProv = Provider.of<NavigationRailProvider>(context);
    return Row(
      children: [
        NavigationRail(
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.add),
              label: Text('Add A Product'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.edit),
              label: Text('Edit Products'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.view_list_outlined),
              label: Text('View all Products'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.paid_rounded),
              label: Text('Sales and Profits'),
            ),
          ],
          selectedIndex: navRailProv.selectedIndex,
          onDestinationSelected: (index) {
            navRailProv.selectindex(index);
          },
          labelType: NavigationRailLabelType.all,
        ),
      ],
    );
  }
}
