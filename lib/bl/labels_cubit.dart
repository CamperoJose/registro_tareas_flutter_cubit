 import 'package:flutter_bloc/flutter_bloc.dart';
import '../dto/labels_response.dart';
import '../services/labels_service.dart';
import 'labels_state.dart';

class LabelsCubit extends Cubit<LabelsState> {
  LabelsCubit() : super(LabelsState());

  Future<void> getLabels() async {
    emit(state.copyWith(status: LabelsStatus.loading));
    try {
      final response = await LabelService.getLabels();
      List<Label> labels = response.labels;
      emit(state.copyWith(status: LabelsStatus.success, labels: labels));
    } catch (e) {
      emit(state.copyWith(status: LabelsStatus.failure));
    }
  }
}