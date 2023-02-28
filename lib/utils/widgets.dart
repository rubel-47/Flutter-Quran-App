import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/utils/color.dart';


Widget HorizontalLine(double height, double width, Color colors) {
  return Container(
    height: height,
    width: width,
    color: colors,
  );
}

Widget VerticalLine() {
  return Container(
    color: Colors.grey.shade300,
    height: 2,
  );
}

Widget VerticalLineModified() {
  return Container(
    color: Colors.grey.shade300,
    height: 20,
  );
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * -0.0033833, size.height * 0.7168857, size.width * 0.0828000, size.height * 0.7133143);
    path.cubicTo(size.width * 0.3025833, size.height * 0.7118571, size.width * 0.7010417, size.height * 0.7118429, size.width * 0.9180833, size.height * 0.7128714);
    path.quadraticBezierTo(size.width * 1.0082750, size.height * 0.7207429, size.width, size.height);
    path.lineTo(size.width, size.height * 0.5275714);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AppbarShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect size, {TextDirection? textDirection}) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * -0.0018083, size.height * 0.7890429, size.width * 0.0843750, size.height * 0.7854714);
    path.cubicTo(size.width * 0.3041583, size.height * 0.7840143, size.width * 0.7004167, size.height * 0.7838286, size.width * 0.9174583, size.height * 0.7848571);
    path.quadraticBezierTo(size.width * 1.0076500, size.height * 0.7927286, size.width, size.height);
    path.lineTo(size.width, size.height * 0.5275714);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
}

class AppbarShapeBorderSurahPage extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect size, {TextDirection? textDirection}) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.cubicTo(size.width, size.height, size.width, size.height, size.width, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double innerCircleRadius = 150.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(rect.width / 2 - 40, rect.height + innerCircleRadius - 40, rect.width / 2 + 40, rect.height + innerCircleRadius - 40, rect.width / 2 + 75, rect.height + 50);
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint paint = new Paint()..color = brownColor;

    canvas.drawPath(getOuterPath(rect), paint);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  CustomAppBar({
    required this.title,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Text('$title'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            )),
        centerTitle: true,
        shape: AppbarShapeBorder(),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarSurahPage extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  CustomAppBarSurahPage({
    required this.title,
    this.height = kToolbarHeight - 100,
  });

  @override
  Size get preferredSize => Size.fromHeight(height - 30);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Text('$title'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            )),
        centerTitle: true,
        shape: AppbarShapeBorderSurahPage(),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class CustomAppBarWithoutLeading extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  CustomAppBarWithoutLeading({
    required this.title,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Text('$title'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            )),
        centerTitle: true,
        shape: AppbarShapeBorder(),
        automaticallyImplyLeading: false,
        actions: [],
      ),
    );
  }
}/*
Widget DropdownButtonSearch(List<DropdownMenuItem> items, dynamic hint,
    dynamic searchHint, Function onChanged,
    {String value = ""}) {
  return SearchableDropdown.single(
    items: items,
    value: value,
    hint: Text('$hint', style: TextStyle(fontSize: 15.0, color: black)),
    icon: Icon(Icons.keyboard_arrow_down_sharp),
    searchHint: Text('$searchHint',
        style: TextStyle(
            fontSize: 19.0, color: black, fontWeight: FontWeight.bold)),
    displayClearIcon: false,
    underline: Container(),
    selectedValueWidgetFn: (item) {
      return Container(
        alignment: Alignment.centerLeft,
        child: (Text(
          item.toString(),
          style: TextStyle(fontSize: 15.0),
        )),
      );
    },
    onChanged: onChanged,
    dialogBox: true,
    isExpanded: true,
  );
}*/
