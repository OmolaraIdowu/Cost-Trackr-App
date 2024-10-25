import 'package:cost_trackr/utils/enums.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:cost_trackr/widgets/button_icon_bg.dart';
import 'package:cost_trackr/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PeriodBalanceScreen extends StatefulWidget {
  const PeriodBalanceScreen({super.key});

  @override
  State<PeriodBalanceScreen> createState() => _PeriodBalanceScreenState();
}

class _PeriodBalanceScreenState extends State<PeriodBalanceScreen> {
  final Currency _selectedCurrency = Currency.ngn;
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submitBalance() {
    final enteredAmount = double.tryParse(_amountController
        .text); // tryParse('Hello) => null, tryParse('20.56') => 20.56
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (amountIsInvalid) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, keyboardSpace + 24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CustomIconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/close.svg',
                    colorFilter: ColorFilter.mode(
                        theme.primaryColorDark, BlendMode.srcIn),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text('Add Period Balance', style: theme.textTheme.titleLarge),
              const SizedBox(height: 40),
              CustomTextfield(
                hint: 'Enter Amount',
                keyboardType: TextInputType.number,
                controller: _amountController,
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: SvgPicture.asset(
                    currencyIcons[_selectedCurrency]!,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .primaryColorDark, // Change color if needed
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomButton(
                text: 'Add to Period Balance',
                onPressed: _submitBalance,
              )
            ],
          ),
        ),
      ),
    );
  }
}
