import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                  suffix: Icons.visibility,
                  suffixPressed: () {},
                  validate: (String? value) {
                    if (value!.isEmpty) return "Password is too short";
                    return null;
                  },
                  label: "*********",
                  prefix: Icons.lock_outlined,
                ),
                SizedBox(height: 30),
                defaultButton(
                  isUpperCase: true,
                  onPressedFunction: () {},
                  text: "Login",
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    defaultTextButton(
                        onPressed: () {
                          navigateTo(context, RegisterScreen());
                        },
                        text: "Register Now"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
