import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/app/constant/api_constant.dart';
import 'package:to_do/app/services/dio_helper/dio_helper.dart';
import 'package:to_do/model/login_model.dart';

import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel = LoginModel();
  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      path: ApiConstant.loginPath,
      data: {
        "password": password,
        "email": email,
      },
    ).then(
      (value) {
        loginModel = LoginModel.fromJson(value.data);
        emit(LoginSuccessState());
      },
    ).catchError(
      (error) {
        emit(LoginErrorState());
      },
    );
  }
}
