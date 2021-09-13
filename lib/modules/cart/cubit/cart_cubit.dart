import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';

import 'states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  List<ProductModel> products = [];
}
