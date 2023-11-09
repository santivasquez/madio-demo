import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:te_regalo/data/madio_repository.dart';
import 'package:te_regalo/data/madio_stores_repository.dart';
import 'package:te_regalo/model/category.dart';
import 'package:te_regalo/model/product_to_show.dart';
import 'package:te_regalo/model/sub_category.dart';
import 'package:te_regalo/model/supplier.dart';
import 'package:te_regalo/screens/shop_screen/controller/shop_screen_state.dart';
part 'shop_screen_controller.g.dart';

@riverpod
class ShopScreenController extends _$ShopScreenController {
  final MadioRepository repository = MadioRepository();
  final MadioStoresRepository storesRepository = MadioStoresRepository();
  List<ProductToShow> productsToShowList = [];
  List<ProductToShow> filteredProductsToShow = [];
  List<Category> categories = [];
  String lastCategorySelected = '';
  bool showSubCategories = false;
  List<SubCategory> subCategories = [];
  List<SubCategory> filteredSubCategories = [];
  String lastSubCategorySelected = '';
  bool supplierIsSelected = false;
  Supplier selectedSupplier = Supplier.empty();
  List<Supplier> suppliers = [];
  bool tryAgain = false;

  @override
  Future<ShopScreenState> build() async {
    productsToShowList = await fetchProducts();
    filteredProductsToShow = productsToShowList;
    categories = await fetchCategroies();
    suppliers = await fetchSuppliers();
    return getData();
  }

  ShopScreenState getData() {
    return ShopScreenState(
        productsToShowList: productsToShowList,
        filteredProductsToShow: filteredProductsToShow,
        categories: categories,
        lastCategorySelected: lastCategorySelected,
        showSubCategories: showSubCategories,
        subCategories: subCategories,
        filteredSubCategories: filteredSubCategories,
        lastSubCategorySelected: lastSubCategorySelected,
        supplierIsSelected: supplierIsSelected,
        selectedSupplier: selectedSupplier,
        suppliers: suppliers,
        tryAgain: tryAgain);
  }

  Future<List<ProductToShow>> fetchProducts() async {
    try {
      final loadedProductsToShow = await repository.getProdcutsToShow();
      filteredProductsToShow = loadedProductsToShow;
      return loadedProductsToShow;
    } catch (e) {
      //tryAgain = true;
      throw Exception(e);
    }
  }

  Future<List<Category>> fetchCategroies() async {
    try {
      final loadedCategories = await repository.getCategories();

      return loadedCategories;
    } catch (e) {
      //tryAgain = true;
      throw Exception(e);
    }
  }

  Future<void> fetchSubCategoriesByCategoryId(String categoryId) async {
    final loadedSubCategories =
        await repository.getSubCategoriesByCategoryId(categoryId);

    if (loadedSubCategories.isNotEmpty) {
      showSubCategories = true;
      filteredSubCategories = loadedSubCategories;
      state = AsyncValue.data(getData());
    }
  }

  Future<List<Supplier>> fetchSuppliers() async {
    final loadedSuppliers =
        await storesRepository.getSuppliersByStoreId('G800pg0m10iROZ4tNHLw');

    return loadedSuppliers;
  }

  void changeTryAgainStatus(bool changedValue) {
    tryAgain = false;
    state = AsyncValue.data(getData());
  }

  void changeSupplierIsSelectedStatus(bool changedValue) {
    supplierIsSelected = false;
    state = AsyncValue.data(getData());
  }

  void handleSelectedSupplier(BuildContext context, Supplier supplier) {
    supplierIsSelected = true;
    selectedSupplier = supplier;
    state = AsyncValue.data(getData());
  }

  void handleSelectedCategory(String categoryId) {
    showSubCategories = false;
    //Filter Products
    List<ProductToShow> filteredProducts = [];
    if (lastCategorySelected != categoryId) {
      fetchSubCategoriesByCategoryId(categoryId);
      filteredProducts = productsToShowList.where((product) {
        return product.product.subCategories.any((subCategory) {
          return subCategory.idCategory == categoryId;
        });
      }).toList();
      lastCategorySelected = categoryId;
      lastSubCategorySelected = '';
    } else {
      showSubCategories = false;
      filteredProducts = productsToShowList;
      lastCategorySelected = '';
    }
    filteredProductsToShow = filteredProducts;
    state = AsyncValue.data(getData());
  }

  void handleSelectedSubCategory(String subCategoryId) {
    //Filter Products
    List<ProductToShow> filteredProducts = [];
    if (lastCategorySelected != subCategoryId) {
      filteredProducts = productsToShowList.where((product) {
        return product.product.subCategories.any((subCategory) {
          return subCategory.id == subCategoryId;
        });
      }).toList();
      lastSubCategorySelected = subCategoryId;
    } else {
      filteredProducts = productsToShowList.where((product) {
        return product.product.subCategories.any((subCategory) {
          return subCategory.idCategory == lastCategorySelected;
        });
      }).toList();
      lastSubCategorySelected = '';
    }

    filteredProductsToShow = filteredProducts;
    state = AsyncValue.data(getData());
  }
}
