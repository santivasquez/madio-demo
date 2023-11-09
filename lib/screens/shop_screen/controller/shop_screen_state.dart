import 'package:te_regalo/model/category.dart';
import 'package:te_regalo/model/product_to_show.dart';
import 'package:te_regalo/model/sub_category.dart';
import 'package:te_regalo/model/supplier.dart';

class ShopScreenState {
  final List<ProductToShow> productsToShowList;
  final List<ProductToShow> filteredProductsToShow;
  final List<Category> categories;
  final String lastCategorySelected;
  final bool showSubCategories;
  final List<SubCategory> subCategories;
  final List<SubCategory> filteredSubCategories;
  final String lastSubCategorySelected;
  final bool supplierIsSelected;
  final Supplier selectedSupplier;
  final List<Supplier> suppliers;
  bool tryAgain;

  ShopScreenState({
    required this.productsToShowList,
    required this.filteredProductsToShow,
    required this.categories,
    required this.lastCategorySelected,
    required this.showSubCategories,
    required this.subCategories,
    required this.filteredSubCategories,
    required this.lastSubCategorySelected,
    required this.supplierIsSelected,
    required this.selectedSupplier,
    required this.suppliers,
    required this.tryAgain,
  });
}
