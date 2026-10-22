import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

//* Categories States
class CategoriesLoadingState extends HomeStates {}

class CategoriesSuccessState extends HomeStates {
  final List<CategoryModel> categories;
  CategoriesSuccessState(this.categories);
}

class CategoriesFailureState extends HomeStates {
  final String failureMessage;
  CategoriesFailureState(this.failureMessage);
}
//* Products States
class ProductsLoadingState extends HomeStates {}

class ProductsSuccessState extends HomeStates {
  final List<ProductModel> products;
  ProductsSuccessState(this.products);
}

class ProductsFailureState extends HomeStates {
  final String failureMessage;
  ProductsFailureState(this.failureMessage);
}

