import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';

class TopMenuBar extends StatelessWidget {
  const TopMenuBar({Key? key, this.caption, this.iconname, this.callback})
      : super(key: key);
  final String? caption;
  final Icon? iconname;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.ru_dark_blue,
      child: SizedBox(
        height: AppBar().preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              child: SizedBox(),
            ),
            Text(
              '$caption',
              style: TextStyle(
                fontSize: 22,
                fontFamily: AppTheme.ruFontKanit,
                color: AppTheme.nearlyWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: callback,
                child: Padding(
                    padding: const EdgeInsets.all(8.0), child: iconname),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
