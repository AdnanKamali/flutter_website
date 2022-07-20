import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/cart/model/Cart.dart';
import 'package:shop_app/cart/repo/cart_services.dart';
import 'package:shop_app/product/model/model.dart';
import 'package:shop_app/product/repo/api_status.dart';
import 'package:shop_app/utils/user_error.dart';

class CartViewModel extends ChangeNotifier {
  CartViewModel() {
    getCarts();
  }
  Future<void> setIfAvailableRefreshToken() async {
    final preference = await SharedPreferences.getInstance();
    final refreshToken = await preference.getString("refresh_token");
    if (refreshToken != null) {
      await CartServices.updateRefreshToken(refreshToken);
    }
  }

  Cart _cartBase = Cart.base();
  Cart get cart => _cartBase;

  void setProduct(ProductModel productModel) {
    _cartBase.product = productModel;
  }

  void setColor(int color) {
    _cartBase.color = color;
  }

  void setNumOfProduct(int numOfProduct) {
    _cartBase.numOfItem = numOfProduct;
  }

  List<Cart> _cartListModel = [];
  List<Cart> get cartListModel => _cartListModel;
  void insertToCartModel(Cart cart) {
    _cartListModel.add(cart);
    setTotalCartPrice();
  }

  void setCartListModel(List<Cart> cartListModel) {
    _cartListModel = cartListModel;
    notifyListeners();
  }

  void deleteCartFromListModel(int id) {
    _cartListModel.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  UserError? _userError;
  UserError? get userError => _userError;
  void setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  double _totalCartPrice = 0;
  double get totalCartPrice => _totalCartPrice;
  void setTotalCartPrice() {
    _totalCartPrice = 0;
    for (final cart in _cartListModel) {
      _totalCartPrice += cart.product!.price * cart.numOfItem!;
    }
    notifyListeners();
  }

  void getCarts() async {
    setLoading(true);
    await setIfAvailableRefreshToken();
    final repo = await CartServices.getCart();
    if (repo is Success) {
      setCartListModel(repo.response as List<Cart>);
      setTotalCartPrice();
    } else {
      final UserError userError = UserError(message: repo);
      setUserError(userError);
    }
    setLoading(false);
  }

  Future<Object> deleteCart(int id) async {
    final repo = await CartServices.deleteCart(id);
    if (repo is Success) {
      deleteCartFromListModel(id);
      setTotalCartPrice();
      return repo;
    } else {
      final UserError userError = UserError(message: repo);
      setUserError(userError);
      return repo;
    }
  }

  Future<Object> postCart() async {
    if (cart.color != null && cart.numOfItem != null && cart.product != null) {
      final repo = await CartServices.postCart(cart);
      if (repo is Success) {
        if (_cartListModel.length == 0) {
          // html.window.location.reload();
          return Success(code: 101);
        }
        final id = _cartListModel.last.id! + 1;
        _cartBase.id = id;

        return repo;
      } else {
        final UserError userError = UserError(message: repo);
        setUserError(userError);
        return repo;
      }
    }
    return UserError(message: "Select All of required");
  }
}
