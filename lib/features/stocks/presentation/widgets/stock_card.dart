part of '../controllers/stocks_controller.dart';

class _StockCard extends StatelessWidget {
  const _StockCard({required this.stock, required this.onTap});

  final StockData stock;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final sparklineColor =
        stock.isGainer ? colorScheme.primary : colorScheme.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Row(
          children: [
            // ── Ticker icon ────────────────────────────────────────
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: stock.iconBg.withOpacity(0.35),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  stock.ticker.substring(0, math.min(3, stock.ticker.length)),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 9.sp,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // ── Name & exchange ────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.ticker,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    stock.name,
                    style: textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // ── Sparkline ──────────────────────────────────────────
            SizedBox(
              width: 60.w,
              height: 34.h,
              child: CustomPaint(
                painter: _SparklinePainter(
                  data: stock.sparklineData,
                  color: sparklineColor,
                ),
              ),
            ),

            SizedBox(width: 14.w),

            // ── Price & change ─────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.formattedPrice,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding:
                      REdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: stock.changeBgColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    stock.formattedChange,
                    style: textTheme.labelSmall?.copyWith(
                      color: stock.changeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Mini sparkline painter ─────────────────────────────────────────────────────
class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SparklinePainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final minVal = data.reduce(math.min);
    final maxVal = data.reduce(math.max);
    final range = (maxVal - minVal).abs();
    final effectiveRange = range < 0.01 ? 1.0 : range;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.18),
          color.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final linePath = Path();
    final fillPath = Path();

    for (int i = 0; i < data.length; i++) {
      final x = i * size.width / (data.length - 1);
      final y = size.height -
          ((data[i] - minVal) / effectiveRange) * size.height * 0.85 -
          size.height * 0.075;

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    // Close fill path
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter old) {
    // Defensive: if old instance is from a previous hot-reload shape,
    // force a repaint rather than crash.
    return old.data != data || old.color != color;
  }
}

// ── Skeleton card ──────────────────────────────────────────────────────────────
class _StockCardSkeleton extends StatefulWidget {
  const _StockCardSkeleton();

  @override
  State<_StockCardSkeleton> createState() => _StockCardSkeletonState();
}

class _StockCardSkeletonState extends State<_StockCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat();
    _shimmer = Tween<double>(begin: -1, end: 2)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _bone({
    required double width,
    required double height,
    double? radius,
    required Color shimmerBase,
    required Color shimmerHighlight,
  }) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, __) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 6.r),
          gradient: LinearGradient(
            stops: const [0.0, 0.5, 1.0],
            colors: [
              shimmerBase,
              shimmerHighlight,
              shimmerBase,
            ],
            transform: GradientRotation(_shimmer.value),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final shimmerBase = brightness == Brightness.dark
        ? AppColors.shimmerBaseDark
        : AppColors.shimmerBase;
    final shimmerHighlight = brightness == Brightness.dark
        ? AppColors.shimmerHighDark
        : AppColors.shimmerHighlight;

    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          _bone(
            width: 44.r,
            height: 44.r,
            radius: 12.r,
            shimmerBase: shimmerBase,
            shimmerHighlight: shimmerHighlight,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bone(
                  width: 80.w,
                  height: 13.h,
                  shimmerBase: shimmerBase,
                  shimmerHighlight: shimmerHighlight,
                ),
                SizedBox(height: 6.h),
                _bone(
                  width: 120.w,
                  height: 10.h,
                  shimmerBase: shimmerBase,
                  shimmerHighlight: shimmerHighlight,
                ),
              ],
            ),
          ),
          _bone(
            width: 60.w,
            height: 34.h,
            shimmerBase: shimmerBase,
            shimmerHighlight: shimmerHighlight,
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bone(
                width: 60.w,
                height: 13.h,
                shimmerBase: shimmerBase,
                shimmerHighlight: shimmerHighlight,
              ),
              SizedBox(height: 6.h),
              _bone(
                width: 46.w,
                height: 20.h,
                radius: 6.r,
                shimmerBase: shimmerBase,
                shimmerHighlight: shimmerHighlight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}