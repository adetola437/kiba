

class InvestmentData {
  final String name;
  final String type;
  final double principal;
  final double returns;
  final double roiPercent;
  final String tenor;
  final DateTime startDate;
  final DateTime maturityDate;
  final double progressPercent; // 0.0 to 1.0
  final bool isMatured;

  const InvestmentData({
    required this.name,
    required this.type,
    required this.principal,
    required this.returns,
    required this.roiPercent,
    required this.tenor,
    required this.startDate,
    required this.maturityDate,
    required this.progressPercent,
    required this.isMatured,
  });
}

final kInvestments = [
  InvestmentData(
    name: 'PMPS — 180 Days',
    type: 'Fixed Income',
    principal: 1000000,
    returns: 9650,
    roiPercent: 17.0,
    tenor: '6-month tenor',
    startDate: DateTime(2026, 1, 1),
    maturityDate: DateTime(2026, 9, 25),
    progressPercent: 0.31,
    isMatured: false,
  ),
  InvestmentData(
    name: 'PMPS — 365 Days',
    type: 'Fixed Income',
    principal: 2000000,
    returns: 28200,
    roiPercent: 18.5,
    tenor: '12-month tenor',
    startDate: DateTime(2025, 12, 15),
    maturityDate: DateTime(2026, 12, 15),
    progressPercent: 0.28,
    isMatured: false,
  ),
  InvestmentData(
    name: 'PMPS — 90 Days',
    type: 'Fixed Income',
    principal: 500000,
    returns: 12150,
    roiPercent: 16.0,
    tenor: '3-month tenor',
    startDate: DateTime(2025, 10, 10),
    maturityDate: DateTime(2026, 1, 10),
    progressPercent: 1.0,
    isMatured: true,
  ),
];