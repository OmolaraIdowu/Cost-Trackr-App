import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  // Helper function to format large numbers
  String _formatCurrency(double amount) {
    return NumberFormat.currency(symbol: 'N ', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/card_bg.png'),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Period Balance',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    'Current Balance',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatCurrency(1000000),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatCurrency(2000000),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Text(
                    'Income',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/icons/arrow_down.svg'),
                  const Spacer(),
                  Text('Expenses',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white)),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/icons/arrow_up.svg'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatCurrency(100000000),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '- ${_formatCurrency(50000000)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
