import 'package:cost_trackr/utils/enums.dart';
import 'package:cost_trackr/widgets/dialog.dart';
import 'package:cost_trackr/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isReminderOn = false;

  Currency selectedCurrency = Currency.ngn;
  String selectedNumberFormat = numberFormats[0];
  String selectedDateFormat = dateFormats[0];
  FirstDayOfWeek selectedFirstDayOfWeek = FirstDayOfWeek.monday;
  Language selectedLanguage = Language.english;

  void _shareApp() async {
    final result =
        await Share.share('Check out Cost Trackr: https://example.com');

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing my app!');
    }
  }

  void _generateStatement() {
    // Logic for generating statements (PDF, image, etc.)
    print("Generating statement...");
  }

  void _setDailyReminders() {
    print('Daily reminders set');
  }

  void _cancelDailyReminders() {
    print('Daily reminders canceled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
          child: Column(children: [
        Expanded(
          child: ListView(
            children: [
              MenuItem(
                icon: Icons.wallet_rounded,
                title: 'Default Currency',
                subtitle: selectedCurrency.name.toUpperCase(),
                onTap: () {
                  CustomDialog.showSelectionDialog<Currency>(
                    context: context,
                    title: 'Select Currency',
                    options: Currency.values,
                    selectedOption: selectedCurrency,
                    onOptionSelected: (Currency currency) {
                      setState(() {
                        selectedCurrency = currency;
                      });
                    },
                    optionLabel: (Currency currency) =>
                        currency.name.toUpperCase(),
                  );
                },
              ),
              MenuItem(
                icon: Icons.format_list_numbered,
                title: 'Number Format',
                subtitle: selectedNumberFormat,
                onTap: () {
                  CustomDialog.showSelectionDialog<String>(
                      context: context,
                      title: 'Select Number Format',
                      options: numberFormats,
                      selectedOption: selectedNumberFormat,
                      onOptionSelected: (String format) {
                        setState(() {
                          selectedNumberFormat = format;
                        });
                      },
                      optionLabel: (String format) => format);
                },
              ),
              MenuItem(
                icon: Icons.calendar_month_rounded,
                title: 'Date Format',
                subtitle: selectedDateFormat,
                onTap: () {
                  CustomDialog.showSelectionDialog<String>(
                      context: context,
                      title: 'Select Date Format',
                      options: dateFormats,
                      selectedOption: selectedDateFormat,
                      onOptionSelected: (String format) {
                        setState(() {
                          selectedDateFormat = format;
                        });
                      },
                      optionLabel: (String format) => format);
                },
              ),
              MenuItem(
                icon: Icons.calendar_month_rounded,
                title: 'First Day of the Week',
                subtitle: selectedFirstDayOfWeek.name[0].toUpperCase() +
                    selectedFirstDayOfWeek.name.substring(1),
                onTap: () {
                  CustomDialog.showSelectionDialog<FirstDayOfWeek>(
                    context: context,
                    title: 'Select First Day of the Week',
                    options: FirstDayOfWeek.values,
                    selectedOption: selectedFirstDayOfWeek,
                    onOptionSelected: (FirstDayOfWeek day) {
                      setState(() {
                        selectedFirstDayOfWeek = day;
                      });
                    },
                    optionLabel: (FirstDayOfWeek day) =>
                        day.name[0].toUpperCase() + day.name.substring(1),
                  );
                },
              ),
              MenuItem(
                icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                title: isDarkMode ? 'Dark Mode' : 'Light Mode',
                hasSwitch: true, // Enable switch
                isSwitchOn: isDarkMode, // Switch state
                onSwitchChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  // Toggle the theme here
                },
              ),
              MenuItem(
                icon: Icons.notifications_on_rounded,
                title: 'Reminder',
                subtitle: 'Set daily reminder for your transactions',
                hasSwitch: true,
                isSwitchOn: isReminderOn,
                onSwitchChanged: (value) {
                  setState(() {
                    isReminderOn = value;
                  });
                  // Handle enabling/disabling reminders here
                  if (isReminderOn) {
                    // Set daily reminders
                    _setDailyReminders();
                  } else {
                    // Cancel daily reminders
                    _cancelDailyReminders();
                  }
                },
              ),
              MenuItem(
                icon: Icons.language,
                title: 'Language',
                subtitle: selectedLanguage.name[0].toUpperCase() +
                    selectedLanguage.name.substring(1),
                onTap: () {
                  CustomDialog.showSelectionDialog<Language>(
                      context: context,
                      title: 'Select Language',
                      options: Language.values,
                      selectedOption: selectedLanguage,
                      onOptionSelected: (Language language) {
                        setState(() {
                          selectedLanguage = language;
                        });
                      },
                      optionLabel: (Language language) =>
                          language.name[0].toUpperCase() +
                          language.name.substring(1));
                },
              ),
              MenuItem(
                icon: Icons.settings,
                title: 'Generate Statement',
                onTap: () {
                  CustomDialog.show(
                    context: context,
                    title: 'Generate Statement',
                    content: 'Coming Soon',
                    confirmText: 'OK',
                    onConfirm: () {},
                  );
                },
              ),
              MenuItem(
                icon: Icons.lock_outline_rounded,
                title: 'Security',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.phone,
                title: 'Contact Us',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.policy,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              MenuItem(
                icon: Icons.share_rounded,
                title: 'Share App',
                onTap: _shareApp,
              ),
            ],
          ),
        ),
      ])),
    );
  }
}

/* */
