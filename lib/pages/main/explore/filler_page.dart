import 'package:flutter/cupertino.dart';
import 'package:rialto/pages/main/navigation_page.dart';

class FillerNavigationPageText extends StatelessWidget
    implements NavigationPage {
  final String text;

  FillerNavigationPageText(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
