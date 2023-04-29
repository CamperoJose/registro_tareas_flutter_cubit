import 'package:equatable/equatable.dart';


enum LoginStatus {init, loading, success, failure }

class LoginState extends Equatable {

  final LoginStatus? status;
  const LoginState({
    this.status,
  });

  LoginState copyWith({
    LoginStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
  
  // Implementa el método 'props' de la clase 'Equatable', que devuelve una
  // lista de las propiedades de la clase. Esto se utiliza para comparar
  // objetos 'LoginState' entre sí, para determinar si son iguales o no.
  @override
  List<Object?> get props => [status];
}
