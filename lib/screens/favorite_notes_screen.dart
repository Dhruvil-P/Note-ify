import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/theme/theme.dart';
import 'package:notes_app/widgets/drawer.dart';
import 'package:notes_app/widgets/note.dart';
import 'package:provider/provider.dart';

class FavoriteNotesScreen extends StatelessWidget {
  static const routeName = '/favorite-notes-screen';

  @override
  Widget build(BuildContext context) {
    final _notes = Provider.of<Notes>(context);

    return Scaffold(
      backgroundColor: primaryColor,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 10,
        foregroundColor: textColor,
        centerTitle: true,
        title: Text('Favorite Notes'),
      ),
      body: _notes.favoriteNotes.isEmpty
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
                    'No favorite note found',
                    style: TextStyle(color: textColor, fontSize: 24),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _notes.favoriteNotes.length,
              itemBuilder: (context, index) {
                return NoteWidget(
                  notesList: _notes.favoriteNotes,
                  index: index,
                  key: ValueKey(_notes.favoriteNotes[index].id),
                );
              },
            ),
    );
  }
}
