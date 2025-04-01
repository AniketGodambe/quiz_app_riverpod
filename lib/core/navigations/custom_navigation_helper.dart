import 'package:flutter/cupertino.dart';

class CustomPageRout extends CupertinoPageRoute {
  final Widget child;

  CustomPageRout({required this.child})
      : super(builder: (BuildContext context) => child);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    const begin = Offset(0.0, 0.0);
    const end = Offset.zero;

    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end);

    final curvedAnimation = CurvedAnimation(curve: curve, parent: animation);

    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
}

pushReplacementPage(
    {required BuildContext context, required Widget destination}) {
  Navigator.pushReplacement(context, CustomPageRout(child: destination));
}

pushPage({required BuildContext context, required Widget destination}) {
  Navigator.push(context, CustomPageRout(child: destination));
}

pushReplacementPageAll(
    {required BuildContext context, required Widget destination}) {
  Navigator.pushAndRemoveUntil(
      context, CustomPageRout(child: destination), (route) => false);
}
