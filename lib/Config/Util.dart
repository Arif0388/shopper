import 'package:flutter/cupertino.dart';

class KeyboardUtil
{
  static void manageKeyboard(BuildContext context)
  {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus)
      {
        currentFocus.unfocus();
      }
  }

}