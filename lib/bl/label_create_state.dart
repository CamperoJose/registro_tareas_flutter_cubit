import 'package:equatable/equatable.dart';

enum LabelCreateStatus { init, loading, success, failure }

class LabelCreateState extends Equatable {
  final LabelCreateStatus status;

  const LabelCreateState({
    this.status = LabelCreateStatus.init,
  });

  get labels => null;

  LabelCreateState copyWith({
    LabelCreateStatus? status,
  }) {
    return LabelCreateState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
