import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(CategoriesLoadingState());

    final categories = await getCategoriesUseCase.invoke();
    final categoryList = categories.fold(
      (failure) {
        emit(CategoriesFailureState(failure.failureMessage));
        return null;
      },
      (categories) {
        emit(CategoriesSuccessState(categories));
        return categories;
      },
    );
    if (categoryList == null || categoryList.isEmpty) return;

    await getProductsByCategoryId(categoryList.first.id);
  }

  Future<void> getProductsByCategoryId(int id) async {
    emit(ProductsLoadingState());
    final products = await getProductsUseCase.invoke(id);
    products.fold(
      (failure) {
        emit(ProductsFailureState(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccessState(products));
      },
    );
  }
}
