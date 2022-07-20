import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/product_title/model/product_title.dart';
import 'package:shop_app/product_title/repo/product_title_services.dart';
import 'package:shop_app/utils/resource_manager/error_manager.dart';
import 'package:shop_app/utils/user_error.dart';

import '../cart/repo/cart_services.dart';
import '../product/model/model.dart';
import '../product/repo/api_status.dart';
import '../product/repo/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  ProductViewModel() {
    getProducts();
    getProductsWithTitle();
  }

  int _selectedColor = 0;
  int get selectedColor => _selectedColor;
  void setSelectedColor(int index) {
    _selectedColor = index;
    notifyListeners();
  }

  int _productCount = 1;
  int get productCount => _productCount;
  void incremnt() {
    _productCount++;
    notifyListeners();
  }

  void decremnt() {
    _productCount--;
    notifyListeners();
  }

  List<ProductModel> _productListModel = [];
  List<ProductModel> get productModelListModel => _productListModel;
  void setProductListModel(List<ProductModel> productListModel) {
    _productListModel = productListModel;
    notifyListeners();
  }

  List<ProductTitleModel> _productListModelWithTitle = [];
  List<ProductTitleModel> get productListModelWithTitle =>
      _productListModelWithTitle;
  void setProductListModelWithTitle(
      List<ProductTitleModel> productListWithTitle) {
    _productListModelWithTitle = productListWithTitle;
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

  void getProducts() async {
    setLoading(true);
    final response = await ProductServices.getProducts();
    if (response is Success) {
      setProductListModel(response.response as List<ProductModel>);
    }
    if (response is ErrorManager) {
      UserError userError = UserError(
        code: response.statusCode,
        message: response.message,
      );
      setUserError(userError);
    }
    setLoading(false);
  }

  void getProductsWithTitle() async {
    setLoading(true);
    final response = await ProductTitleServices.getTitles();
    if (response is Success) {
      setProductListModelWithTitle(
          response.response as List<ProductTitleModel>);
    }
    if (response is ErrorManager) {
      UserError userError = UserError(
        code: response.statusCode,
        message: response.message,
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}
