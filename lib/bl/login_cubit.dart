import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await LoginService.login(email, password);
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }

}
