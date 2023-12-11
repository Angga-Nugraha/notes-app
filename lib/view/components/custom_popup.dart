part of 'components_helper.dart';

PopupMenuButton<int> customPopup(
  BuildContext context, {
  required String title1,
  required IconData icon1,
  String? title2,
  IconData? icon2,
  required Function(int) onSelected,
}) {
  return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(title1),
              ],
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: title2 == null
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        icon2,
                        color: Colors.black,
                      ),
                      Text(title2),
                    ],
                  ),
          ),
        ];
      },
      onSelected: onSelected);
}
