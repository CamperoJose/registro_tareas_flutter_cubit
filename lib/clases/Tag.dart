import 'dart:ffi';

class Tag {
  String tagName;
  bool visible;

  Tag(this.tagName, {this.visible = true});

  getTagname() {
    return tagName;
  }

  bool setDelete() {
    visible = false;
    return true;
  }
}
