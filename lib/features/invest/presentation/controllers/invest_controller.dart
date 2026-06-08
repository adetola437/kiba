import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/features/beige_club/presentation/controllers/beige_club_dashboard_controller.dart';
import 'package:kiba/features/invest/presentation/controllers/new_investment_controller.dart';

import '../../../../core/models/invest_product_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import 'investment_details_controller.dart';

part '../contracts/invest_contract.dart';
part '../views/invest_view.dart';
part '../widgets/invest_hero_banner.dart';
part '../widgets/invest_category_tabs.dart';
part '../widgets/invest_product_card.dart';

class InvestScreen extends StatefulWidget {
  static const String route = 'invest';
  const InvestScreen({super.key});

  @override
  State<InvestScreen> createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen>
    implements InvestControllerContract {
  late final InvestViewContract view;

  @override
  bool isLoading = true;

  @override
  InvestCategory activeCategory = InvestCategory.all;

  @override
  List<InvestProductData> get filteredProducts {
    if (activeCategory == InvestCategory.all) return kInvestProducts;
    return kInvestProducts
        .where((p) => p.category == activeCategory)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    view = InvestView(controller: this);
    // Simulate API load
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => isLoading = false);
    });
  }

  @override
  void onCategoryChanged(InvestCategory category) =>
      setState(() => activeCategory = category);

  @override
  void onProductTap(InvestProductData product) {
     if (product.isLocked) {
      context.pushNamed('kyc');
      return;
    }
    if(product.name.toLowerCase() == 'beige club'){
      context.pushNamed(BeigeClubDashboardScreen.route);
      return;
    }
  context.pushNamed(InvestmentDetailScreen.route,
  extra: {'hasActiveInvestment': false});
  }

  @override
  void onPrimaryAction(InvestProductData product) {
    if (product.isLocked) {
      context.pushNamed('kyc');
      return;
    }
    if(product.name.toLowerCase() == 'beige club'){
      context.pushNamed(BeigeClubDashboardScreen.route);
      return;
    }
    context.pushNamed(NewInvestmentScreen.route, extra: {
      'productName': product.name,
      // 'minAmount': product.minInvestment,
    });
  }

  @override
  void onViewRateGuide() => context.pushNamed('rate_guide');

  @override
  Widget build(BuildContext context) => view.build(context);
}