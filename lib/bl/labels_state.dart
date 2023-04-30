import 'package:equatable/equatable.dart';

import '../dto/labels_response.dart';

enum LabelsStatus { init, loading, success, failure }

class LabelsState extends Equatable {
  final LabelsStatus status;
  final List<Label> labels;

  const LabelsState({
    this.status = LabelsStatus.init,
    this.labels = const [],
  });

  LabelsState copyWith({
    LabelsStatus? status,
    List<Label>? labels,
  }) {
    return LabelsState(
      status: status ?? this.status,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [status, labels];
}
