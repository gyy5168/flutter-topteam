import 'package:flutter/material.dart';
import 'package:topteam/widgets/form_item.dart';

class FormItemGroup extends StatelessWidget {
  final List<FormItem> children;

  const FormItemGroup({
    Key key,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FormItem> visibleItems = children.where((item) => item.stage).toList();
    List<Widget> items = [];
    visibleItems.asMap().keys.forEach((index) {
      items.add(this.children[index]);
      if (index != visibleItems.length - 1) {
        items.add(Divider(
          color: Color(0xfff2f2f2),
          height: 1,
          thickness: 1,
        ));
      }
    });
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xfff2f2f2)), bottom: BorderSide(color: Color(0xfff2f2f2)))
      ),
      child: Column(
        children: items,
      ),
    );
  }
}