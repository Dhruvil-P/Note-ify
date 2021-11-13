import 'package:flutter/material.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/screens/favorite_notes_screen.dart';
import 'package:notes_app/screens/homepage.dart';
import 'package:notes_app/screens/new_note_screen.dart';
import 'package:notes_app/screens/note_detail_screen.dart';
import 'package:notes_app/screens/pinned_notes_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Notes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          PinnedNotesScreen.routeName: (ctx) => PinnedNotesScreen(),
          FavoriteNotesScreen.routeName: (ctx) => FavoriteNotesScreen(),
          NoteDetailScreen.routeName: (ctx) => NoteDetailScreen(),
          NewNoteScreen.routeName: (ctx) => NewNoteScreen(),
        },
        home: SafeArea(child: HomePage()),
      ),
    );
  }
}
