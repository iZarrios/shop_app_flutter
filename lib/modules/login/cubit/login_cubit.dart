import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // make object of the cubit
  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel _loginModel;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$email", password: "$password");
      print("Done logging in");
      print(userCredential.toString());
      // _loginModel = LoginModel.fromJson({})
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // DioHelper.postData(
  //   path: ApiDataAndEndPoints.loginPathUrl,
  //   data: {
  //     'email': email,
  //     'password': password,
  //   },
  // ).then((value) {
  //   _loginModel = LoginModel.fromJson(value.data);
  //   emit(LoginSuccess(_loginModel));
  // }).catchError((errorMessage) {
  //   emit(LoginError(errorMessage.toString()));
  // });
// password text field
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibility());
  }
}
