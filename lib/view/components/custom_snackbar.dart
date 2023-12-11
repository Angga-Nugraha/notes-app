part of 'components_helper.dart';

void mySnackbar(BuildContext context, {required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width / 2,
      content: Center(child: Text(title))));
}
