import 'package:flutter_bloc/flutter_bloc.dart';

import '../clases/Note.dart';
import '../clases/PendingTasks.dart';
import '../clases/Tag.dart';
import '../clases/TagList.dart';

class TagsCubit extends Cubit<ListedTags> {
  TagsCubit() : super(listedTags);

  void addTag(Tag tag) {
    listedTags.addTag(tag);
    emit(listedTags);
  }

  void listedTag(){
    emit(listedTags);
  }


  void setNewTags(List<Tag> tags1) {
    listedTags.setNewTags(tags1);
    emit(listedTags);
  }

  void deleteTag(int index) {
    listedTags.removeAt(index);
    emit(listedTags);
  }

  void addTagToTask(int index, int indexTask) {
    listedTags.getTagByIndex(index).visible = false;
    PendingTasksList.getNote(indexTask).tags.add(listedTags.getTagByIndex(index));
    emit(listedTags);
  }

  void deleteTagFromTask(int index, int indexTask) {
    listedTags.getTagByIndex(index).visible = true;
    PendingTasksList.getNote(indexTask).tags.remove(listedTags.getTagByIndex(index));
    emit(listedTags);
  }

  void deleteAllTagsFromTask(int indexTask) {
    for (int i = 0; i < PendingTasksList.getNote(indexTask).tags.length; i++) {
      listedTags.getTagByIndex(i).visible = true;
    }
    PendingTasksList.getNote(indexTask).tags = [];
    emit(listedTags);
  }

  void deleteAllTags() {
    for (int i = 0; i < listedTags.getSize(); i++) {
      listedTags.getTagByIndex(i).visible = true;
    }
    listedTags.tags = [];
    emit(listedTags);
  }


}
