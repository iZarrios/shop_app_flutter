import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../../models/login_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  // make object of the cubit
  static RegisterCubit get(context) => BlocProvider.of(context);
  late LoginModel _registerModel;
  late UserData _user;

  void userRegister({
    required String phone,
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "$email", password: "$password");
      print("Success Registration");
      final DatabaseReference db = FirebaseDatabase.instance.reference();
      _user = UserData(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        password: password,
        favourites: null,
        points: 0,
        credit: 0,
      );
      await db
          .child("users")
          .child("${userCredential.user!.uid}")
          .set(_user.toMap())
          .then((value) => print("Done cloud register"))
          .catchError((e) {
        print("Error cloud register ${e.toString()}");
      });
      // ProductModel x = ProductModel(
      //   id: 100,
      //   price: "price",
      //   oldPrice: "oldPrice",
      //   discount: " discount",
      //   image: " image",
      //   name: "name",
      //   inFavorites: false,
      //   inCart: false,
      // );
      // Map _newUserCart = {
      //   "${x.id}": x.toMap(),
      // };
      // await db
      //     .child("carts")
      //     .child("${userCredential.user!.uid}")
      //     .set(_newUserCart)
      //     .then((value) => print("Done New Cart Upload"))
      //     .catchError((e) {
      //   print("Error New Cart Upload $e");
      // });
      emit(RegisterSucess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast(
            text: 'The account already exists for that email.',
            state: ToastStates.ERROR);
      }
    } catch (errorMessage) {
      print(errorMessage.toString());
      emit(RegisterError(errorMessage.toString()));
    }
  }

// password text field
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibality());
  }
}
