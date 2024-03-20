import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/view/bloc/notes_bloc/note_bloc.dart';
import 'package:notes_app/view/bloc/pdf_bloc/pdf_bloc.dart';
import 'package:notes_app/view/components/components_helper.dart';
import 'package:notes_app/view/home_page.dart';

import '../data/model/notes_model.dart';
import '../utils/constants.dart';

class ViewNoteForm extends StatefulWidget {
  final NoteModel? note;
  final ActionType type;
  const ViewNoteForm({this.note, this.type = ActionType.addNote, super.key});

  @override
  State<ViewNoteForm> createState() => _ViewNoteFormState();
}

class _ViewNoteFormState extends State<ViewNoteForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final UndoHistoryController _contentHistoryController =
      UndoHistoryController();
  final DateTime now = DateTime.now();
  Color? _color;
  Color? selectedColor;

  @override
  void initState() {
    _titleController.text = widget.note != null ? widget.note!.title : '';
    _contentController.text = widget.note != null ? widget.note!.body : '';
    _color =
        widget.note != null ? Color(widget.note!.colorValue) : selectedColor;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contentHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeInDown(
            duration: const Duration(milliseconds: 300),
            child: Text(widget.type != ActionType.addNote
                ? 'Detail Note'
                : 'Create Note')),
        centerTitle: true,
        actions: [
          FadeInLeft(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              splashRadius: 15,
              onPressed: () {
                final title = _titleController.value.text;
                final content = _contentController.value.text;

                if (title.isNotEmpty && content.isNotEmpty) {
                  if (widget.type == ActionType.editNote) {
                    final newNote = NoteModel(
                      id: widget.note!.key ?? widget.note!.id,
                      title: _titleController.text,
                      body: _contentController.text,
                      createdAt: now.toIso8601String(),
                      colorValue: _color?.value ?? selectedColor!.value,
                    );

                    context.read<NoteBloc>().add(
                          UpdateNotes(newNote),
                        );
                  } else {
                    final newNote = NoteModel(
                      title: _titleController.text,
                      body: _contentController.text,
                      createdAt: now.toIso8601String(),
                      colorValue: selectedColor != null
                          ? selectedColor!.value
                          : Colors.white.value,
                    );

                    context.read<NoteBloc>().add(
                          AddNotes(newNote),
                        );
                  }
                } else {
                  mySnackbar(context, title: 'Fill the Title and Content !!!');
                }
              },
              icon: const Icon(Icons.save_as),
              tooltip: 'Save',
            ),
          ),
          FadeInRight(
            duration: const Duration(milliseconds: 300),
            child: customPopup(
              context,
              icon1: FontAwesomeIcons.filePdf,
              title1: 'Save as PDF',
              icon2: widget.type == ActionType.addNote
                  ? null
                  : Icons.delete_outline_outlined,
              title2: widget.type == ActionType.addNote ? null : 'Delete',
              onSelected: (value) {
                switch (value) {
                  case 0:
                    final data = {
                      "title": _titleController.value.text,
                      "content": _contentController.value.text,
                    };
                    if (_titleController.value.text.isNotEmpty &&
                        _contentController.value.text.isNotEmpty) {
                      context.read<PDFBloc>().add(SaveAsPdf(data));
                    } else {
                      mySnackbar(context,
                          title: 'Fill the Title and Content !!!');
                    }
                  case 1:
                    widget.type == ActionType.addNote
                        ? () {}
                        : myDialog(
                            context,
                            onPressed: () {
                              context
                                  .read<NoteBloc>()
                                  .add(DeleteNote(widget.note!.key));
                            },
                          );
                  default:
                }
              },
            ),
          ),
        ],
      ),
      body: FadeIn(
        duration: const Duration(milliseconds: 700),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
              color: _color ?? selectedColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                const BoxShadow(
                    color: Colors.white, blurRadius: 5, offset: Offset(-3, 3)),
                BoxShadow(
                    color: _color ?? Colors.white,
                    blurRadius: 5,
                    offset: const Offset(3, -3))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                ),
                const Divider(
                  color: Colors.black54,
                  thickness: 1,
                ),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TextField(
                      controller: _contentController,
                      undoController: _contentHistoryController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Content here...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              borderRadius: BorderRadius.circular(10.0),
              dropdownColor: const Color.fromARGB(209, 0, 0, 0),
              elevation: 0,
              value: selectedColor ?? color.first,
              items: color
                  .map<DropdownMenuItem<Color>>(
                    (e) => DropdownMenuItem<Color>(
                      value: e,
                      child: Center(
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: e,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                  _color = selectedColor;
                });
              },
            ),
            const Spacer(),
            BlocConsumer<NoteBloc, NoteState>(
              listener: (context, state) {
                switch (state) {
                  case NoteAdded():
                    mySnackbar(context, title: state.result);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const HomePage()),
                      (route) => false,
                    );
                  case NoteUpdated():
                    mySnackbar(context, title: state.result);

                  case NoteDeleted():
                    mySnackbar(context, title: state.result);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const HomePage()),
                      (route) => false,
                    );
                  default:
                    break;
                }
              },
              builder: (context, state) {
                switch (state) {
                  case NoteLoading():
                    return TweenAnimationBuilder(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(seconds: 1),
                      builder: (context, value, child) {
                        return SizedBox(
                          width: 50,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const Text(
                                'Saving',
                                style: TextStyle(color: Colors.white),
                              ),
                              LinearProgressIndicator(
                                value: value,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
            const Spacer(),
            ValueListenableBuilder<UndoHistoryValue>(
              valueListenable: _contentHistoryController,
              builder: (context, value, child) {
                return Row(
                  children: [
                    IconButton(
                        color: value.canUndo ? Colors.white : Colors.grey,
                        onPressed: () {
                          _contentHistoryController.undo();
                        },
                        icon: const Icon(Icons.undo)),
                    IconButton(
                        color: value.canRedo ? Colors.white : Colors.grey,
                        onPressed: () {
                          _contentHistoryController.redo();
                        },
                        icon: const Icon(Icons.redo))
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
