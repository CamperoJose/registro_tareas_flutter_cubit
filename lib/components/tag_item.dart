import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../clases/Note.dart';
import '../clases/Tag.dart';

class TagItem extends StatefulWidget {
  Tag TagA;

  TagItem(this.TagA);

  @override
  _TagItem createState() => _TagItem();
}

class _TagItem extends State<TagItem> {

  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.TagA.getTagname()}"),
                SizedBox(height: 4),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
