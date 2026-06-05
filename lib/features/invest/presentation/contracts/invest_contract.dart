part of '../controllers/invest_controller.dart';



abstract class InvestControllerContract {
  bool get isLoading;
  InvestCategory get activeCategory;
  List<InvestProductData> get filteredProducts;

  void onCategoryChanged(InvestCategory category);
  void onProductTap(InvestProductData product);
  void onPrimaryAction(InvestProductData product);
  void onViewRateGuide();
}

abstract class InvestViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
