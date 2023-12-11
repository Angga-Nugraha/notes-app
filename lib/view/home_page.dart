import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/view/bloc/notes_bloc/note_bloc.dart';
import 'package:notes_app/view/components/components_helper.dart';
import 'package:notes_app/view/view_note_form.dart';
import 'package:open_file/open_file.dart';
import 'package:timer_builder/timer_builder.dart';
import "package:file_picker/file_picker.dart";
import 'package:permission_handler/permission_handler.dart';
import 'widgets/gridview_content.dart';
import 'widgets/listview_content.dart';

import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isGridView = true;

  void _pickDocument() async {
    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.paths.first!);
      await OpenFile.open(file.path);
    }
  }

  @override
  void initState() {
    Future.microtask(() =>
        BlocProvider.of<NoteBloc>(context, listen: false).add(FetchNotes()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadeInDown(
            duration: const Duration(milliseconds: 700),
            child: const Text('Note App')),
        actions: [
          FadeInDown(
            duration: const Duration(milliseconds: 700),
            child: IconButton(
              onPressed: () {
                _pickDocument();
              },
              icon: const Icon(
                FontAwesomeIcons.folderOpen,
                size: 20,
              ),
            ),
          ),
          FadeInDown(
            duration: const Duration(milliseconds: 700),
            child: customPopup(
              context,
              icon1: Icons.note_add,
              title1: 'Add Note',
              icon2: Icons.settings,
              title2: 'Settings',
              onSelected: (value) {
                switch (value) {
                  case 0:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewNoteForm(),
                        ));
                  case 1:
                    mySnackbar(context, title: 'Comming soon');
                  default:
                }
              },
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<NoteBloc>().add(FetchNotes()),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimerBuilder.periodic(const Duration(seconds: 1),
                        builder: (context) {
                      return Text(
                        dateFormat.format(DateTime.now()),
                        style: const TextStyle(
                            color: Color(0xff2d386b),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      );
                    }),
                    const Spacer(),
                    const Text('Layout:'),
                    const SizedBox(width: 10.0),
                    isGridView
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                isGridView = false;
                              });
                            },
                            child: const Icon(Icons.grid_view))
                        : InkWell(
                            onTap: () {
                              setState(() {
                                isGridView = true;
                              });
                            },
                            child: const Icon(Icons.list)),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    switch (state) {
                      case NoteLoading():
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case NoteLoaded():
                        final note = state.result;
                        if (note.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/lottie/empty.json',
                                    width: 100),
                                const Text(
                                  'You don\'t have any notes',
                                  style: TextStyle(
                                      color: Color(0xff2d386b),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          );
                        } else {
                          return isGridView
                              ? GridNoteContent(note: note)
                              : ListNoteContent(note: note);
                        }
                      default:
                        return const Text('');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewNoteForm(),
                ));
          },
          child: const Icon(FontAwesomeIcons.pencil)),
    );
  }

  // PopupMenuButton<int> customPopup(BuildContext context) {
  //   return PopupMenuButton(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //     itemBuilder: (context) {
  //       return [
  //         PopupMenuItem(
  //           value: 0,
  //           child: Row(
  //             children: [
  //               Icon(
  //                 Icons.note_add,
  //                 color: Theme.of(context).colorScheme.primary,
  //               ),
  //               const Text('New Note'),
  //             ],
  //           ),
  //         ),
  //         const PopupMenuItem(
  //           value: 1,
  //           child: Row(
  //             children: [
  //               Icon(
  //                 Icons.settings,
  //                 color: Colors.black,
  //               ),
  //               Text('Settings'),
  //             ],
  //           ),
  //         ),
  //       ];
  //     },
  //     onSelected: (value) {
  //       switch (value) {
  //         case 0:
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => const ViewNoteForm(),
  //               ));
  //         case 1:
  //           break;
  //         default:
  //       }
  //     },
  //   );
  // }
}
