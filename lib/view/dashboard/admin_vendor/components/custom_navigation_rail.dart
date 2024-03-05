import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/main.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/add_product.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/components/navigation_rail_providers.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_vendor/edit_product.dart';
import 'package:zenify_admin_panel/view/dashboard/view_products.dart';

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
        Expanded(
          flex: 1,
          child: NavigationRail(
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
        ),
        Expanded(
          flex: 4,
          child: (() {
            if (navRailProv.selectedIndex == 0) {
              // Add a product Screen
              return AddProduct();
            } else if (navRailProv.selectedIndex == 1) {
              return EditProductPage();
            } else if (navRailProv.selectedIndex == 2) {
              return ViewProducts();
            } else if (navRailProv.selectedIndex == 3) {
              return Text(
                'Sale and Profits',
                style: TextStyle(fontSize: 55),
              );
            }
            // Return a default widget if none of the conditions are met
            return Container(); // or any other default widget
          })(),
        )
      ],
    );
  }
}
