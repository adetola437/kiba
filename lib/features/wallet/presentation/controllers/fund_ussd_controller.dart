import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';

part '../contracts/fund_ussd_contract.dart';
part '../views/fund_ussd_view.dart';
part '../widgets/ussd_bank_tile.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model
// ─────────────────────────────────────────────────────────────────────────────

class _UssdBank {
  final String name;
  final String code;
  final Color color;

  const _UssdBank({
    required this.name,
    required this.code,
    required this.color,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class FundUssdScreen extends StatefulWidget {
  static const String route = 'fund_ussd';
  const FundUssdScreen({super.key});

  @override
  State<FundUssdScreen> createState() => _FundUssdScreenState();
}

class _FundUssdScreenState extends State<FundUssdScreen>
    implements FundUssdControllerContract {
  late final FundUssdViewContract view;

  static const List<_UssdBank> _banks = [
    _UssdBank(name: 'GTBank', code: '*737#', color: Color(0xFFE05D00)),
    _UssdBank(name: 'Zenith Bank', code: '*966#', color: Color(0xFFCC0000)),
    _UssdBank(name: 'Kuda Bank', code: '*5573#', color: Color(0xFF400080)),
    _UssdBank(name: 'Access Bank', code: '*901#', color: Color(0xFFFF6600)),
    _UssdBank(name: 'UBA', code: '*919#', color: Color(0xFFE31E24)),
    _UssdBank(name: 'First Bank', code: '*894#', color: Color(0xFF003087)),
    _UssdBank(name: 'Sterling Bank', code: '*822#', color: Color(0xFF009A44)),
    _UssdBank(name: 'Wema Bank', code: '*945#', color: Color(0xFF8B1A4A)),
  ];

  @override
  late final ValueNotifier<String> searchQuery = ValueNotifier('');

  @override
  late final TextEditingController searchCtrl = TextEditingController();

  @override
  List<_UssdBank> get filteredBanks {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) return _banks;
    return _banks.where((b) => b.name.toLowerCase().contains(q)).toList();
  }

  @override
  void initState() {
    super.initState();
    searchCtrl.addListener(() => searchQuery.value = searchCtrl.text);
    view = FundUssdView(controller: this);
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    searchQuery.dispose();
    super.dispose();
  }

  @override
  Future<void> onSelectBank(_UssdBank bank) async {
    final dialUri = Uri(scheme: 'tel', path: bank.code);
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    }
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}