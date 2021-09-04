import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        "Login Now to Browse our hot offers!",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 30),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty)
                            return "Please enter your email address";
                          return null;
                        },
                        label: "example@domain.com",
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(height: 30),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) return "Password is too short";
                          return null;
                        },
                        label: "*********",
                        prefix: Icons.lock_outlined,
                      ),
                      SizedBox(height: 30),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) =>
                              state is! ShopLoginLoadingState,
                          widgetBuilder: (context) => defaultButton(
                                isUpperCase: true,
                                onPressedFunction: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: "Login",
                              ),
                          fallbackBuilder: (BuildContext context) {
                            return Center(child: CircularProgressIndicator());
                          }),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          defaultTextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: "Register Now"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
