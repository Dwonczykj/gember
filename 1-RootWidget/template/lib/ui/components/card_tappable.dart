import 'package:flutter/material.dart';

class CardTappable extends StatelessWidget {
  final Widget child;

  const CardTappable({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: InkWell(
          onTap: () {},
          splashColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          highlightColor: Colors.transparent,
          child: child),
    );
  }
}
