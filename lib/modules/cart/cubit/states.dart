abstract class CartStates {}

class CartInitial extends CartStates {}

//cart
class CartLoading extends CartStates {}

class CartDataSuccess extends CartStates {}

class CartDataError extends CartStates {
  final String error;

  CartDataError(this.error);
}

//items
class RemoveItemSuccess extends CartStates {}

class RemoveItemError extends CartStates {
  final String error;

  RemoveItemError(this.error);
}

class RemoveItemLoading extends CartStates {}
