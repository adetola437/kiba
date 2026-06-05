class TenorOption {
  final int days;
  final double rate;
  final String label;

  const TenorOption({
    required this.days,
    required this.rate,
    required this.label,
  });
}

const kTenors = [
  TenorOption(days: 30,  rate: 11.5, label: '30 DAYS'),
  TenorOption(days: 90,  rate: 12.5, label: '90 DAYS'),
  TenorOption(days: 180, rate: 13.5, label: '180 DAYS'),
  TenorOption(days: 365, rate: 18.5, label: '365 DAYS'),
];


const kQuickAmounts = [100000.0, 250000.0, 500000.0, 1000000.0];
