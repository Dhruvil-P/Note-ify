import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/screens/new_note_screen.dart';
import 'package:notes_app/theme/theme.dart';
import 'package:notes_app/widgets/drawer.dart';
import 'package:notes_app/widgets/note.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(context) {
    final _notes = Provider.of<Notes>(context);

    return Scaffold(
      backgroundColor: primaryColor,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 10,
        foregroundColor: textColor,
        centerTitle: true,
        title: const Text('Note-ify'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NewNoteScreen.routeName);
            },
            icon: Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: _notes.notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/not_found.svg',
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'No note found',
                    style: TextStyle(color: textColor, fontSize: 24),
                  ),
                ],
              ),
            )
          : ReorderableListView(
              physics: const BouncingScrollPhysics(),
              onReorder: (int oldIndex, int newIndex) {
                _notes.reorderList(oldIndex, newIndex);
              },
              children: <Widget>[
                for (var index = 0; index < _notes.notes.length; index++)
                  NoteWidget(
                    notesList: _notes.notes,
                    index: index,
                    key: ValueKey(_notes.notes[index].id),
                  ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NewNoteScreen.routeName);
          },
          backgroundColor: activeColor,
          splashColor: shadowColor,
          elevation: 5,
          child: Icon(
            CupertinoIcons.add,
            color: shadowColor,
            size: 36,
          ),
        ),
      ),
    );
  }
}
