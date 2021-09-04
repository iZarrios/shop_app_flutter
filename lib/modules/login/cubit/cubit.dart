import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN, //endpoints
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
