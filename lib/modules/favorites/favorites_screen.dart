import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/models/home_model.dart';
import '../../shared/components/components.dart';
import '../../layout/cubit/shop_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  late final Map itemsMap;

  // var cubit = ShopCubit.get(context);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return _builder(context, state);
      },
    );
  }

  Widget _builder(context, state) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => _conditionBuilder(context, state),
      widgetBuilder: _widgetBuilder,
      fallbackBuilder: _fallbackBuilder,
    );
  }

  bool _conditionBuilder(BuildContext context, state) {
    // return state is! LoadingFavoritesData;
    return true;
    // return ShopCubit.get(context).favouritesMap.length > 0 ? true : false;
  }

  Widget _widgetBuilder(context) {
    Map data = ShopCubit.get(context).favouritesMap;
    // print(data);
    List keys = data.keys.toList();
    print(data.length);
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildListProduct(
        data[keys[index]],
        context,
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: data.length,
    );
  }

  Widget _fallbackBuilder(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
