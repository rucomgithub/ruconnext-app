import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key, this.caption, this.iconname, this.callback})
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Container(
                width: AppBar().preferredSize.height - 8,
                height: AppBar().preferredSize.height - 8,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppTheme.nearlyWhite,
                  ),
                  onPressed: () {
                    // Handle back button pressed
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '$caption',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: AppTheme.ruFontKanit,
                      color: AppTheme.nearlyWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Container(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: callback,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: iconname),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
