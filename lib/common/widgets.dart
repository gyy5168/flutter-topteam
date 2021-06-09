import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppText extends StatelessWidget {

  final String data;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  AppText(this.data, {
    Key key,
    this.fontSize = 14,
    this.color = const Color(0xff333333),
    this.fontWeight = FontWeight.normal
  }) : assert(
        data != null,
        'A non-null String must be provided to a Text widget.',
      ),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      fontSize: this.fontSize,
      color: this.color,
      fontWeight: this.fontWeight
    );
    return Text(data, style: style,);
  }
}
class Popper extends StatefulWidget {
  Popper({
    Key key,
    @required this.child,
    @required this.content,
    this.contentWidth = 120,
    this.offset = 0,
  });
  final Widget child;
  final List<PopperItem> content;
  final double contentWidth;
  final double offset;
  @override
  _PopperState createState() => _PopperState();
}

class _PopperState extends State<Popper> {
  GlobalKey anchorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.child,
      key: anchorKey,
      onTap: () {
        List<PopperItem> visibleItems = widget.content.where((item) => item.stage).toList();
        List<Widget> content = [];
        visibleItems.asMap().keys.forEach((index) {
          content.add(visibleItems[index]);
          if (index != visibleItems.length - 1) {
            content.add(Divider(
              color: Color(0xfff2f2f2),
              height: 1,
              thickness: 1,
            ));
          }
        });
        RenderBox renderBox = anchorKey.currentContext.findRenderObject();
        Size size = renderBox.size;
        var offset = renderBox.localToGlobal(Offset.zero);
        Size windowSize = MediaQuery.of(context).size;
        var left, right;
        if (offset.dx + size.width / 2 - widget.contentWidth / 2 < 0) {
          left = 0;
        }
        if (offset.dx + size.width / 2 + widget.contentWidth / 2 > windowSize.width) {
          right = 0;
        }
        var top;
        if (offset.dy > windowSize.height - offset.dy -  size.height) {
          top = 0;
        }
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (p1, p2, p3) {
              return Material(
                color: Colors.transparent,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Positioned(
                          top: top == 0 ? null : offset.dy + size.height + widget.offset,
                          bottom: top == 0 ? windowSize.height - offset.dy + widget.offset : null,
                          left: left == 0 ? 0 : right == 0 ? null : offset.dx + size.width / 2 - widget.contentWidth / 2,
                          right: right == 0 ? 0 : null,
                          // left: 
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                            width: widget.contentWidth,
                            // height: 110,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, .1),
                                  offset: Offset(0, 0),
                                  blurRadius: 12,
                                  spreadRadius: 2
                                ),
                              ]
                            ),
                            child: Column(
                              children: content,
                            ),
                          ),
                        ),
                        Positioned(
                          left: offset.dx + size.width / 2 - 6,
                          top: top == 0 ? null : offset.dy + size.height - 5 + widget.offset,
                          bottom: top == 0 ? windowSize.height - offset.dy - 5 + widget.offset : null,
                          child: Container(
                            width: 12,
                            height: 6,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, .1),
                                  offset: top == 0 ? Offset(0, 2) : Offset(0, -2),
                                  blurRadius: 12,
                                  spreadRadius: 2
                                ),
                              ]
                            ),
                            child: CustomPaint(
                              size: Size(12, 6),
                              painter: TrianglePainter(
                                invert: top == 0,
                                color: Color(0xffffffff)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          )
        );
      }
    );
  }
}

class PopperItem extends StatelessWidget {
  PopperItem({
    Key key,
    @required this.child,
    this.onTap,
    this.stage = true
  });
  final Widget child;
  final GestureTapCallback onTap;
  final bool stage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pop();
        this.onTap();
      }
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool invert;
  Paint _paint;

  TrianglePainter({
    this.color = Colors.white,
    this.invert = false
  }){
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    if (this.invert) {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
      path.moveTo(0, 0);
    } else {
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.moveTo(size.width / 2, 0);
    }

    path.close();
    canvas.drawPath(
      path,
      _paint
    );
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TrianglePainter oldDelegate) => false;
}