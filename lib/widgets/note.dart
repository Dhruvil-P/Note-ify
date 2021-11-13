import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/classes/note.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/screens/note_detail_screen.dart';
import 'package:notes_app/theme/theme.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  final List<Note> notesList;
  final int index;
  final Key key;

  NoteWidget({required this.notesList, required this.index, required this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _notes = Provider.of<Notes>(context);

    return Container(
      key: key,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: shadowColor, width: 5),
      ),
      child: Dismissible(
        key: Key(notesList[index].toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(20),
          child: Icon(CupertinoIcons.delete),
        ),
        confirmDismiss: (direction) async {
          return await showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text(
                    'Delete Note',
                    style: TextStyle(fontSize: 24),
                  ),
                  actions: [
                    CupertinoButton(
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: 16, color: activeColor),
                        ),
                        onPressed: () {
                          _notes.removeNote(notesList[index].id);
                          Navigator.of(context).pop();
                        }),
                    CupertinoButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16, color: activeColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
        },
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              NoteDetailScreen.routeName,
              arguments: notesList[index],
            );
          },
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                notesList[index].title.isEmpty
                    ? 'New Note'
                    : notesList[index].title.length <= 15
                        ? notesList[index].title
                        : '${notesList[index].title.substring(0, 10)}...',
                style: TextStyle(fontSize: 24, color: textColor),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                notesList[index].description.isEmpty
                    ? 'No specific description provided'
                    : notesList[index].description.length <= 30
                        ? notesList[index].description
                        : '${notesList[index].description.substring(0, 30)}...',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _notes.pinNote(notesList[index].id);
                    },
                    icon: Icon(
                        notesList[index].isPinned
                            ? CupertinoIcons.pin_fill
                            : CupertinoIcons.pin,
                        color: Colors.lightGreen,
                        size: 24),
                  ),
                  IconButton(
                    onPressed: () {
                      _notes.favNote(notesList[index].id);
                    },
                    icon: Icon(
                        notesList[index].isFavorite
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: Colors.red,
                        size: 24),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
