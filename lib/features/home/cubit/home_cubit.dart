import 'package:ecommerce_app_huma_volve/features/home/cubit/home_states.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeService homeService;
  HomeCubit(this.homeService):super(HomeInitialState());

  void loadHomeData() async {
    emit(CategoriesLoadingState());
    try {
      final categories = await homeService.getCategories();
      emit(CategoriesSuccessState( categories));
      final products = await homeService.getProducts(categories[0].id);
      emit(ProductsSuccessState(products));
    } catch (e) {
      emit(CategoriesFailureState(e.toString()));
    }
  }

Future<void> getProductsByCategory(int categoryId) async {
  emit(ProductsLoadingState());
  try {
    final products = await homeService.getProducts(categoryId);
    emit(ProductsSuccessState(products));
  } catch (e) {
    emit(ProductsFailureState(e.toString()));
  }
}
}