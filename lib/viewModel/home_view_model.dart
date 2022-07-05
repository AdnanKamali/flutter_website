import 'package:flutter/cupertino.dart';
// import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/utils/resource_manager/error_manager.dart';
import 'package:shop_app/utils/user_error.dart';

import '../product/model/model.dart';
import '../product/repo/api_status.dart';
import '../product/repo/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  ProductViewModel() {
    getProducts();
  }
  int _selectedColor = 0;
  int get selectedColor => _selectedColor;
  void setSelectedColor(int index) {
    _selectedColor = index;
    notifyListeners();
  }

  List<ProductModel> _productListModel = [];
  List<ProductModel> get productModelListModel => _productListModel;
  void setProductListModel(List<ProductModel> productListModel) {
    _productListModel = productListModel;
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
      // print(response.errResponse);
      UserError userError = UserError(
        code: response.statusCode,
        message: response.message,
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}
