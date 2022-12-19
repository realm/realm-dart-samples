import 'package:flutter/material.dart';
import 'package:flutter_todo/theme.dart';

Widget formLayout(BuildContext context, Widget? contentWidget) {
  return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
          child: Center(
            child: contentWidget,
          )));
}

Widget loginField(TextEditingController controller,
    {String? labelText, String? hintText, bool? obscure}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: TextField(
        obscureText: obscure ?? false,
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText)),
  );
}

Widget loginButton(BuildContext context,
    {void Function()? onPressed, Widget? child}) {
  return Container(
    height: 50,
    width: 250,
    margin: const EdgeInsets.symmetric(vertical: 25),
    child: ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.white, fontSize: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)))),
      onPressed: onPressed,
      child: child,
    ),
  );
}

Widget templateButton(BuildContext context,
    {Color color = Colors.grey,
    String text = "button",
    void Function()? onPressed}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
      onPressed: onPressed,
      child: Text(text),
    ),
  );
}

Widget cancelButton(BuildContext context) {
  return templateButton(
    context,
    text: "Cancel",
    onPressed: () => Navigator.pop(context),
  );
}

Widget okButton(BuildContext context, String text,
    {void Function()? onPressed}) {
  return templateButton(
    context,
    color: forestGreenColor,
    text: text,
    onPressed: onPressed,
  );
}

Widget deleteButton(BuildContext context, {void Function()? onPressed}) {
  return templateButton(
    context,
    color: darkRedColor,
    text: "Delete",
    onPressed: onPressed,
  );
}

RadioListTile<bool> radioButton(
    String text, bool value, ValueNotifier<bool> controller) {
  return RadioListTile(
    title: Text(text),
    value: value,
    onChanged: (v) => controller.value = v ?? false,
    groupValue: controller.value,
  );
}

Widget styledBox(BuildContext context, {bool isHeader = false, Widget? child}) {
  return Container(
    width: double.infinity,
    decoration: headerFooterBoxDecoration(context, isHeader),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: child,
    ),
  );
}

Widget styledFloatingAddButton(BuildContext context,
    {required void Function() onPressed}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.white,
      onPressed: onPressed,
      tooltip: 'Add',
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: CircleAvatar(
          radius: 26,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      ),
    ),
  );
}

extension ShowSnack on SnackBar {
  void show(BuildContext context, {int durationInSeconds = 15}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(this);
  Future.delayed(Duration(seconds: durationInSeconds)).then((value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  });
}
}

SnackBar infoMessageSnackBar(BuildContext context, String message) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 200.0),
      dismissDirection: DismissDirection.none,
      content: SizedBox(
          height: 105,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: infoBoxDecoration(context),
              child: Text(message,
                  style: infoTextStyle(context), textAlign: TextAlign.center),
            ),
          )));
}

SnackBar errorMessageSnackBar(
    BuildContext context, String title, String message) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 200.0),
      dismissDirection: DismissDirection.none,
      content: SizedBox(
          height: 105,
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: errorBoxDecoration(context),
                child: Column(
                  children: [
                    Text(title, style: errorTextStyle(context, bold: true)),
                    Expanded(
                        child: Text(message, style: errorTextStyle(context))),
                  ],
                )),
          )));
}

Container waitingIndicator() {
  return Container(
    color: Colors.black.withOpacity(0.2),
    child: const Center(child: CircularProgressIndicator()),
  );
}
