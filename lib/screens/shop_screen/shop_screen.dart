import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:te_regalo/model/supplier.dart';
import 'package:te_regalo/presentation/common/halfstack.dart';
import 'package:te_regalo/screens/shop_screen/categories_list.dart';
import 'package:te_regalo/screens/shop_screen/controller/shop_screen_controller.dart';
import 'package:te_regalo/screens/shop_screen/list_products_to_show.dart';
import 'package:te_regalo/screens/shop_screen/sub_categories_list.dart';
import 'package:te_regalo/screens/suppliers_screen/supplier_list.dart';
import 'package:te_regalo/screens/suppliers_screen/supplier_logo_button.dart';

class ShopScreen extends ConsumerWidget {
  ShopScreen({super.key});

  void showSupplierDescription(BuildContext context, Supplier supplier) {
    HalfStackWidget.show(
        context: context, headerText: 'headerText', body: Text('data'));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(shopScreenControllerProvider);

    return controller.when(data: (state) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    width: state.supplierIsSelected ? 90.0 : 0.0,
                    height: state.supplierIsSelected ? 90.0 : 0.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                    child: SupplierLogoButton(
                        supplier: state.selectedSupplier,
                        selectedSupplier: showSupplierDescription),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 8,
                        child: AnimatedContainer(
                          height: 100,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FadeInImage(
                              image: NetworkImage(state.supplierIsSelected
                                  ? state.selectedSupplier.imageBanner
                                  : "https://media.gq.com.mx/photos/5be9e8c5396b74e7791d9d01/16:9/w_1280,c_limit/buen_fin_3404.jpg"),
                              placeholder: AssetImage(
                                  "assets/images/No-Image-Placeholder.png"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/No-Image-Placeholder.png',
                                  fit: BoxFit.fitWidth,
                                );
                              },
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                  alignment: Alignment.topLeft,
                  height: state.supplierIsSelected ? 30.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: TextButton(
                    onPressed: () {
                      ref
                          .read(shopScreenControllerProvider.notifier)
                          .changeSupplierIsSelectedStatus(false);
                    },
                    child: Text('Ver Tiendas'),
                  )),
              AnimatedContainer(
                height: state.supplierIsSelected ? 0.0 : 80.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                child: SuppliersList(
                  suppliers: state.suppliers,
                  selectedSupplier: ref
                      .read(shopScreenControllerProvider.notifier)
                      .handleSelectedSupplier,
                ),
              ),
              const SizedBox(height: 8),
              state.categories.isNotEmpty
                  ? CategoriesList(
                      categories: state.categories,
                      selected: state.lastCategorySelected,
                      selectedCategories: ref
                          .read(shopScreenControllerProvider.notifier)
                          .handleSelectedCategory,
                    )
                  : const SizedBox(),
              AnimatedContainer(
                  height: state.showSubCategories ? 50.0 : 0.0,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.fastOutSlowIn,
                  child: SubCategoriesList(
                    subcategories: state.filteredSubCategories,
                    selected: state.lastSubCategorySelected,
                    selectedSubCategories: ref
                        .read(shopScreenControllerProvider.notifier)
                        .handleSelectedSubCategory,
                  )),
              const SizedBox(height: 16),
              if (state.tryAgain)
                Center(
                  child: TextButton(
                    child: Text('Try again'),
                    onPressed: () {
                      ref
                          .read(shopScreenControllerProvider.notifier)
                          .changeTryAgainStatus(false);
                    },
                  ),
                )
              else
                ListProductsToShow(state.filteredProductsToShow),
            ],
          ),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Center(
        child: TextButton(
          child: Text('Try again'),
          onPressed: () {
            ref
                .read(shopScreenControllerProvider.notifier)
                .changeTryAgainStatus(false);
          },
        ),
      );
    }, loading: () {
      return Center(child: Text('loading'));
    });
  }
}
