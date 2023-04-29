import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final response = await LoginService.login(email, password);
      String at = response.response.getAuthToken();
      print("AuthToken generado exitosamente: $at");
      await FlutterKeychain.put(key: "AuthToken", value: at);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
