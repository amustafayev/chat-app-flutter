import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {},
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.home),
                  onTap: () {},
                ),
              ),

            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
