import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
// import 'package:shop_app/modules/cart/cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var cubit = CartCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Conditional.single(
        context: context,
        conditionBuilder: (context) => _conditionBuilder(),
        fallbackBuilder: (context) => _buildFallBack(),
        widgetBuilder: (context) => ListView.separated(
            itemBuilder: (context, index) => _buildItem(),
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemCount: 10),
      ),
    );
  }

  Widget _buildItem() => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            Container(
                height: 100,
                width: 100,
                child: Image.asset("assets/images/onboard_1.jpg")),
            Text("test"),
          ],
        ),
      );

  Widget _buildFallBack() => Center(child: Text("No Items in your cart!"));

  bool _conditionBuilder() {
    //if length more than one
    return true;
  }
}
