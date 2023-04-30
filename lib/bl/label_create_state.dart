import 'package:equatable/equatable.dart';

enum LabelCreateStatus { init, loading, success, failure }

class LabelCreateState extends Equatable {
  final LabelCreateStatus status;
  final List<String> labels;
  final String? selectedLabel;

  const LabelCreateState({
    this.status = LabelCreateStatus.init,
    this.labels = const [],
    this.selectedLabel,
  });

  LabelCreateState copyWith({
    LabelCreateStatus? status,
    List<String>? labels,
    String? selectedLabel,
  }) {
    return LabelCreateState(
      status: status ?? this.status,
      labels: labels ?? this.labels,
      selectedLabel: selectedLabel ?? this.selectedLabel,
    );
  }

  @override
  List<Object?> get props => [status, labels, selectedLabel];
}
