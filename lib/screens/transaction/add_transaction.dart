import 'package:cost_trackr/model/category.dart';
import 'package:cost_trackr/model/transaction.dart';
import 'package:cost_trackr/utils/enums.dart';
import 'package:cost_trackr/utils/form_validator.dart';
import 'package:cost_trackr/utils/snackbar.dart';
import 'package:cost_trackr/widgets/button.dart';
import 'package:cost_trackr/widgets/dropdown.dart';
import 'package:cost_trackr/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _enteredAmount = 0.0;
  var _enteredDescription = '';

  // Default selected values
  final Currency _selectedCurrency = Currency.ngn;
  TransactionType _selectedTransaction = TransactionType.income;
  Category _selectedCategory = Category(
    title: '',
    icon: const Icon(Icons.list_rounded),
  );

  // Submit Transaction
  void _submitTransaction() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // Create the transaction object
      final transaction = Transaction(
        amount: _enteredAmount,
        currency: _selectedCurrency,
        transactionType: _selectedTransaction,
        category: _selectedCategory,
        description: _enteredDescription,
        date: DateTime.now(),
      );

      // Save the transaction to Firestore
      // await FirebaseFirestore.instance.collection('transactions').add(transaction.toMap());

      // Show success message and reset form
      context.showSnackBar('Transaction added successfully');
      _resetForm();
      Navigator.pop(context);
    } catch (error) {
      // Show error message
      context.showSnackBar('Failed to add transaction: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Reset form fields
  void _resetForm() {
    _enteredAmount = 0.0;
    _enteredDescription = '';
    _selectedCategory = Category(
      title: '',
      icon: const Icon(Icons.list_rounded),
    );
    _formKey.currentState!.reset();
  }

  // Main Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _amountField(),
                  const SizedBox(height: 20),
                  _transactionTypeDropdown(),
                  const SizedBox(height: 20),
                  _categoryField(context),
                  const SizedBox(height: 20),
                  _descriptionField(),
                  const SizedBox(height: 55),
                  _saveButton(),
                ],
              )),
        ),
      )),
    );
  }

  // Amount Field
  Widget _amountField() {
    return CustomTextfield(
      heading: 'Amount',
      hint: 'Enter Amount',
      height: 100,
      keyboardType: TextInputType.number,
      prefix: Padding(
        padding: const EdgeInsets.only(left: 16, right: 10),
        child: SvgPicture.asset(
          currencyIcons[_selectedCurrency]!,
          width: 10,
          height: 10,
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorDark,
            BlendMode.srcIn,
          ),
        ),
      ),
      validator: FormValidator.validateAmount,
      onSaved: (value) {
        _enteredAmount = double.tryParse(value!)!;
      },
    );
  }

  Widget _categoryField(BuildContext context) {
    return CustomTextfield(
      heading: 'Category',
      hint: _selectedCategory.title ?? 'Select a category',
      readOnly: true,
      prefix: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColorLight,
          child: _selectedCategory.icon,
        ),
      ),
      suffix: IconButton(
        onPressed: () => _showCategoryDialog(context),
        icon: const Icon(Icons.add),
      ),
      validator: (value) {
        if (_selectedCategory.title == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        String? iconSelected = '';
        String categoryTitle = '';

        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: Text('Create a Category',
                  style: Theme.of(ctx).textTheme.titleMedium),
              contentPadding: const EdgeInsets.all(24),
              backgroundColor: Theme.of(ctx).shadowColor,
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Field
                    CustomTextfield(
                      heading: 'Title',
                      hint: 'Enter a title',
                      onChanged: (value) {
                        categoryTitle = value;
                      },
                      validator: FormValidator.validateName,
                    ),
                    const SizedBox(height: 16),
                    // Icon Grid View
                    Flexible(
                      child: GridView.builder(
                        itemCount: categoryIcons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                iconSelected = categoryIcons[index];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: iconSelected == categoryIcons[index]
                                    ? Border.all(
                                        color: Theme.of(ctx).primaryColor,
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/${categoryIcons[index]}.svg',
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context).primaryColorDark,
                                      BlendMode.srcIn),
                                  height: 24,
                                  width: 24),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                CustomButton(
                  text: 'Save Category',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                  onPressed: () {
                    // Create category object and pop

                    Navigator.of(ctx).pop();
                    context.showSnackBar('Category created successfully!');
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(ctx).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _descriptionField() {
    return CustomTextfield(
      heading: 'Description',
      hint: 'Enter Description',
      maxLines: 8,
      validator: FormValidator.validateDescription,
      onSaved: (value) {
        _enteredDescription = value!;
      },
    );
  }

  Widget _saveButton() {
    return Stack(children: [
      CustomButton(
        text: _isLoading ? '' : 'Save Transaction',
        onPressed: _isLoading ? null : _submitTransaction,
      ),
      if (_isLoading)
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
    ]);
  }

  Widget _transactionTypeDropdown() {
    return CustomDropdown<TransactionType>(
      heading: 'Transaction Type',
      value: _selectedTransaction,
      items: TransactionType.values.map((type) {
        return DropdownMenuItem<TransactionType>(
          value: type,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type.name[0].toUpperCase() + type.name.substring(1),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (_selectedTransaction == type) ...[
                Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                )
              ]
            ],
          ),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return TransactionType.values.map<Widget>((TransactionType type) {
          return Text(
            type.name[0].toUpperCase() + type.name.substring(1),
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }).toList();
      },
      onChanged: (value) => setState(() => _selectedTransaction = value!),
      onSaved: (value) => _selectedTransaction = value!,
    );
  }
}
