part of '../controllers/stock_detail_controller.dart';

class _StockPriceChart extends StatelessWidget {
  final StockData stock;
  final ChartRange selectedRange;
  final ValueChanged<ChartRange> onRangeChanged;

  const _StockPriceChart({
    required this.stock,
    required this.selectedRange,
    required this.onRangeChanged,
  });

  static const _ranges = [
    (range: ChartRange.oneDay, label: '1D'),
    (range: ChartRange.oneWeek, label: '1W'),
    (range: ChartRange.oneMonth, label: '1M'),
    (range: ChartRange.threeMonths, label: '3M'),
    (range: ChartRange.oneYear, label: '1Y'),
  ];

  List<double> _chartData() {
    final base = stock.sparklineData;
    switch (selectedRange) {
      case ChartRange.oneDay:
        return base.take(4).toList();
      case ChartRange.oneWeek:
        return base;
      case ChartRange.oneMonth:
        return [...base, ...base.map((v) => v * 0.98).toList()];
      case ChartRange.threeMonths:
        return [
          ...base.map((v) => v * 0.93).toList(),
          ...base.map((v) => v * 0.96).toList(),
          ...base,
        ];
      case ChartRange.oneYear:
        return [
          ...base.map((v) => v * 0.80).toList(),
          ...base.map((v) => v * 0.88).toList(),
          ...base.map((v) => v * 0.94).toList(),
          ...base,
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Chart canvas
        Container(
          height: 180.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: colorScheme.outline),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CustomPaint(
              painter: _ChartPainter(
                data: _chartData(),
                isGainer: stock.isGainer,
                dividerColor: colorScheme.outline.withOpacity(0.5),
                surfaceColor: colorScheme.surface,
              ),
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // Range selector
        Row(
          children: _ranges.map((r) {
            final isActive = r.range == selectedRange;
            return Expanded(
              child: GestureDetector(
                onTap: () => onRangeChanged(r.range),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 32.h,
                  margin: REdgeInsets.symmetric(horizontal: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive ? colorScheme.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    r.label,
                    style: textTheme.labelSmall?.copyWith(
                      color: isActive
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ── Full chart painter ─────────────────────────────────────────────────────────
class _ChartPainter extends CustomPainter {
  final List<double> data;
  final bool isGainer;
  final Color dividerColor;
  final Color surfaceColor;

  _ChartPainter({
    required this.data,
    required this.isGainer,
    required this.dividerColor,
    required this.surfaceColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final minVal = data.reduce(math.min);
    final maxVal = data.reduce(math.max);
    final range = (maxVal - minVal).abs();
    final effectiveRange = range < 0.01 ? 1.0 : range;
    const vPad = 0.15;

    double getY(double v) =>
        size.height -
        ((v - minVal) / effectiveRange) *
            size.height *
            (1 - 2 * vPad) -
        size.height * vPad;

    final color =
        isGainer ? const Color(0xFF1A8C5B) : const Color(0xFFB00020);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.20),
          color.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Grid lines
    final gridPaint = Paint()
      ..color = dividerColor
      ..strokeWidth = 0.8;

    for (int i = 1; i < 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final linePath = Path();
    final fillPath = Path();

    for (int i = 0; i < data.length; i++) {
      final x = i * size.width / (data.length - 1);
      final y = getY(data[i]);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        final prevX = (i - 1) * size.width / (data.length - 1);
        final prevY = getY(data[i - 1]);
        final cp1x = prevX + (x - prevX) / 2;
        linePath.cubicTo(cp1x, prevY, cp1x, y, x, y);
        fillPath.cubicTo(cp1x, prevY, cp1x, y, x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    // Current price dot
    final lastX = size.width;
    final lastY = getY(data.last);
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final dotBorderPaint = Paint()
      ..color = surfaceColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(lastX, lastY), 7, dotBorderPaint);
    canvas.drawCircle(Offset(lastX, lastY), 5, dotPaint);
  }

  @override
  bool shouldRepaint(_ChartPainter old) =>
      old.data != data ||
      old.isGainer != isGainer ||
      old.dividerColor != dividerColor ||
      old.surfaceColor != surfaceColor;
}