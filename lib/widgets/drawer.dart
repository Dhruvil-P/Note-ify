import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/favorite_notes_screen.dart';
import 'package:notes_app/screens/homepage.dart';
import 'package:notes_app/screens/pinned_notes_screen.dart';
import 'package:notes_app/theme/theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: primaryColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Notes',
                  style: TextStyle(fontSize: 36, color: textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Divider(
                  color: textColor,
                  thickness: 2,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                },
                leading: Icon(CupertinoIcons.home, size: 24, color: textColor),
                title: Text(
                  'Home Page',
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(PinnedNotesScreen.routeName);
                },
                leading: Icon(CupertinoIcons.pin, size: 24, color: textColor),
                title: Text(
                  'Pinned Notes',
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(FavoriteNotesScreen.routeName);
                },
                leading: Icon(CupertinoIcons.heart, size: 24, color: textColor),
                title: Text(
                  'Favorite Notes',
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
