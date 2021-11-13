import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/providers/notes.dart';
import 'package:notes_app/theme/theme.dart';
import 'package:notes_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class NewNoteScreen extends StatefulWidget {
  static const routeName = '/new-note-screen';

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _notes = Provider.of<Notes>(context);

    void validateForm() {
      if (_titleController.text.isEmpty) {
        _notes.addNote('', _descController.text);
        showSnackBar(context, 'New note created.');
      } else if (_descController.text.isEmpty) {
        _notes.addNote(_titleController.text, '');
        showSnackBar(context, 'New note created.');
      } else if (_titleController.text.isNotEmpty &&
          _descController.text.isNotEmpty) {
        _notes.addNote(_titleController.text, _descController.text);
        showSnackBar(context, 'New note created.');
      }
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 10,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(CupertinoIcons.back),
            ),
            actions: [
              IconButton(
                  onPressed: validateForm,
                  icon: Icon(CupertinoIcons.floppy_disk))
            ],
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
                        keyboardType: TextInputType.text,
                        maxLength: 25,
                        controller: _titleController,
                        style: TextStyle(color: textColor, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Enter your title...',
                          labelStyle: TextStyle(color: textColor),
                        ),
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
                        decoration: InputDecoration(
                          labelText: 'Enter your description',
                          labelStyle: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: CupertinoButton(
                        child: Text(
                          'Create',
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
          )),
    );
  }
}
