import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/main.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/add_product.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/navigation_rail_providers.dart';

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
          useIndicator: true,
          extended: true,
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.add),
                label: Text('Add A Product'),
                selectedIcon: Icon(
                  Icons.add_outlined,
                  color: MyAppColors.primaryred,
                )),
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
          // labelType: NavigationRailLabelType.all,
        ),
        Expanded(
          child: Column(
            children: [
              if (navRailProv.selectedIndex == 0)
                //Add a product Screen
                AddProduct()
              else if (navRailProv.selectedIndex == 1)
                Text(
                  'Edit Products',
                  style: TextStyle(fontSize: 55),
                )
              else if (navRailProv.selectedIndex == 2)
                Text(
                  'View all Product',
                  style: TextStyle(fontSize: 55),
                )
              else if (navRailProv.selectedIndex == 3)
                Text(
                  'Sale and Profits',
                  style: TextStyle(fontSize: 55),
                ),
            ],
          ),
        )
      ],
    );
  }
}
