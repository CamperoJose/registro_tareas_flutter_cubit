import 'package:flutter_bloc/flutter_bloc.dart';

import '../clases/Note.dart';
import '../clases/PendingTasks.dart';
import '../clases/Tag.dart';
import '../clases/TagList.dart';

class TagsCubit extends Cubit<ListedTags> {
  TagsCubit() : super(listedTags);

  void addTag(Tag tag) {
    final newTags = List<Tag>.from(listedTags.tags)..add(tag);
    listedTags = ListedTags(newTags);
    emit(listedTags);
  }

  void removeAt(int index) {
    final newList = ListedTags(
      List<Tag>.from(state.tags)..removeAt(index),
    );
    listedTags = newList;
    emit(listedTags);
  }

  void setNewTags(List<Tag>? tags) {
    final newList = ListedTags(
      tags ?? [],
    );
    emit(newList);
  }

  void deleteTag(Tag tag) {
    final newList = ListedTags(
      List<Tag>.from(state.tags)..remove(tag),
    );
    emit(newList);
  }

  listedTag() {
    emit(listedTags);
    listedTags;
  }
}
