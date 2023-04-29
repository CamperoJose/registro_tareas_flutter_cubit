import 'package:equatable/equatable.dart';


enum TaskStatus {init, loading, success, failure }

class LoginState extends Equatable {
  final TaskStatus status;

  const LoginState({
    this.status = TaskStatus.init,
  });

  LoginState copyWith({
    TaskStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
  @override
  List<Object?> get props => [status];
}



