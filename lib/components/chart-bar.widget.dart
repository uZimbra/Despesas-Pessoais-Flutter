import 'package:expenses/core/app_colors.core.dart';
import 'package:flutter/material.dart';

class ChartBarWidget extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBarWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(value.toStringAsFixed(2)),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.grey,
                        width: 1,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
