part of 'components_helper.dart';

Future<dynamic> myDialog(BuildContext context,
    {required VoidCallback onPressed}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        title: const Text(
          'Delete Note',
          style: TextStyle(
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        content: const Text(
          'Are you sure want to delete this note?',
          style: TextStyle(
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          TextButton(
              onPressed: onPressed,
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
        ],
      );
    },
  );
}
