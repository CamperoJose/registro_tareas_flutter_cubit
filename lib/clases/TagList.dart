import 'package:registro_tareas_flutter_cubit/clases/Tag.dart';

class ListedTags {
  List<Tag> tags = [];
  ListedTags(this.tags);

  addTag(Tag tag) {
    tags.add(tag);
  }

  removeAt(int index) {
    tags.removeAt(index);
  }

  getSize(){
    return tags.length;
  }


  Tag getTag(int index) {
    List<Tag> visibleTags = tags.where((tag) => tag.visible == true).toList();
    return visibleTags[index];
  }

  getVisbleTags() {
    List<Tag> visibleTags = tags.where((tag) => tag.visible == true).toList();
    return visibleTags;
  }

  setNewTags(List<Tag> tags1) {
    tags = tags1;
  }



  getTagByIndex(int index) {
    return tags[index];
  }

  copyWith({required List<Tag> tags}){
    return ListedTags(tags);
  }


}

List<Tag> tags1 = [Tag("Trabajo"), Tag("Universidad")];
ListedTags listedTags = ListedTags(tags1);
