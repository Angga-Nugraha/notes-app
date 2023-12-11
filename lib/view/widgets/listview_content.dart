import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/notes_model.dart';
import '../../utils/constants.dart';
import '../bloc/notes_bloc/note_bloc.dart';
import '../view_note_form.dart';

class ListNoteContent extends StatelessWidget {
  final List<NoteModel> note;
  const ListNoteContent({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final date = DateTime.parse(note[index].createdAt);
        return FadeInLeft(
          duration: const Duration(milliseconds: 400),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoteForm(
                        note: note[index], type: ActionType.editNote),
                  ));
            },
            child: Dismissible(
              key: Key(note[index].key.toString()),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                context.read<NoteBloc>().add(DeleteNote(note[index].key));
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Color(note[index].colorValue),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.white,
                          blurRadius: 5,
                          offset: Offset(-2, 2)),
                      BoxShadow(
                          color: Color(note[index].colorValue),
                          blurRadius: 5,
                          offset: const Offset(2, -2))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      note[index].title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Text(
                      note[index].body,
                      style: const TextStyle(
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      dateFormat.format(date),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 8,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: note.length,
    );
  }
}
