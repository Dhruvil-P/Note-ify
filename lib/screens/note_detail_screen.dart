import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/classes/note.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/theme/theme.dart';
import 'package:notes_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  static const routeName = "/note-detail-screen";

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  var _titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _notes = Provider.of<Notes>(context);
    final _note = ModalRoute.of(context)!.settings.arguments as Note;

    final _titleController = TextEditingController(text: _note.title);
    final _descController = TextEditingController(text: _note.description);

    void validateForm() {
      if (_titleController.text.isEmpty) {
        _notes.updateNote(_note.id, '', _descController.text);
        showSnackBar(context, 'Note updated.');
      } else if (_descController.text.isEmpty) {
        _notes.updateNote(_note.id, _titleController.text, '');
        showSnackBar(context, 'Note updated.');
      } else if (_titleController.text.isNotEmpty &&
          _descController.text.isNotEmpty) {
        _notes.updateNote(
            _note.id, _titleController.text, _descController.text);
        showSnackBar(context, 'Note updated.');
      }
    }

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(CupertinoIcons.back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _notes.pinNote(_note.id);
              },
              icon: Icon(
                  _note.isPinned ? CupertinoIcons.pin_fill : CupertinoIcons.pin,
                  color: Colors.lightGreen,
                  size: 24),
            ),
            IconButton(
              onPressed: () {
                _notes.favNote(_note.id);
              },
              icon: Icon(
                  _note.isFavorite
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: Colors.red,
                  size: 24),
            )
          ],
          backgroundColor: primaryColor,
          elevation: 10,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Form(
            child: Container(
              margin: EdgeInsets.all(20),
              width: _size.width,
              height: _size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: textColor.withOpacity(0.1),
                    ),
                    child: TextFormField(
                      focusNode: _titleFocusNode,
                      keyboardType: TextInputType.text,
                      maxLength: 25,
                      controller: _titleController,
                      style: TextStyle(color: textColor, fontSize: 18),
                      onChanged: (newValue) {
                        _notes.updateNote(
                            _note.id, newValue, _descController.text);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: textColor.withOpacity(0.1),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: 10,
                      controller: _descController,
                      style: TextStyle(color: textColor, fontSize: 18),
                      onChanged: (newValue) {
                        _notes.updateNote(
                            _note.id, _titleController.text, newValue);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: CupertinoButton(
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: shadowColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      color: activeColor,
                      borderRadius: BorderRadius.circular(20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      pressedOpacity: 0.8,
                      onPressed: validateForm,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
