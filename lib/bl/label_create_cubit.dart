import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/label_create_service.dart';
import 'label_create_state.dart';

class LabelCreateCubit extends Cubit<LabelCreateState> {
  LabelCreateCubit() : super(LabelCreateState());

  Future<void> createLabel(String name, String date) async {
    emit(state.copyWith(status: LabelCreateStatus.loading));
    try {
      final response = await LabelCreateService.createLabel(name, date);
      if (response.code == '0000') {
        emit(state.copyWith(status: LabelCreateStatus.success));
      } else {
        emit(state.copyWith(status: LabelCreateStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: LabelCreateStatus.failure));
    }
  }

  Future<void> updateLabel(
      int labelId, String name, String date) async {
    emit(state.copyWith(status: LabelCreateStatus.loading));
    try {
      final response =
          await LabelCreateService.updateLabel(labelId, name, date, false);
      if (response.code == '0000') {
        emit(state.copyWith(status: LabelCreateStatus.success));
      } else {
        emit(state.copyWith(status: LabelCreateStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: LabelCreateStatus.failure));
    }
  }

  Future<void> deleteLabel(
      int labelId, String name, String date, bool a) async {
    emit(state.copyWith(status: LabelCreateStatus.loading));
    try {
      final response =
          await LabelCreateService.updateLabel(labelId, name, date, a);
      if (response.code == '0000') {
        emit(state.copyWith(status: LabelCreateStatus.success));
      } else {
        emit(state.copyWith(status: LabelCreateStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: LabelCreateStatus.failure));
    }
  }


}
