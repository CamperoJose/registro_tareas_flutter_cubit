// Importa la librería 'equatable', que se utilizará para implementar
// comparaciones entre objetos de manera sencilla.
import 'package:equatable/equatable.dart';

// Define una enumeración llamada 'LoginStatus', que representa los
// diferentes estados que puede tener el proceso de inicio de sesión.
enum LoginStatus { loading, success, failure }

// Define una clase llamada 'LoginState' que extiende la clase 'Equatable'.
class LoginState extends Equatable {
  // Define tres propiedades para la clase: 'email', 'password' y 'status'.
  final String? email;
  final String? password;
  final LoginStatus? status;

  // Define un constructor constante que acepta valores opcionales para
  // 'email', 'password' y 'status'.
  const LoginState({
    this.email,
    this.password,
    this.status,
  });

  // Define un método llamado 'copyWith' que devuelve una nueva instancia de
  // 'LoginState' con los valores actualizados de 'email', 'password' y/o
  // 'status'. Si se proporciona un valor nulo para una propiedad determinada,
  // se utilizará el valor actual de esa propiedad.
  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
  
  // Implementa el método 'props' de la clase 'Equatable', que devuelve una
  // lista de las propiedades de la clase. Esto se utiliza para comparar
  // objetos 'LoginState' entre sí, para determinar si son iguales o no.
  @override
  List<Object?> get props => [email, password, status];
}
