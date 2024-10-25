enum TransactionType { income, expense }

enum Currency { usd, ngn, eur, gbp, jpy }

const currencyIcons = {
  Currency.usd: 'assets/icons/dollar.svg',
  Currency.eur: 'assets/icons/euro.svg',
  Currency.ngn: 'assets/icons/naira.svg',
  Currency.gbp: 'assets/icons/pound.svg',
  Currency.jpy: 'assets/icons/yen.svg'
};

enum Language {
  english,
  french,
  spanish,
  german,
  chinese,
  japanese,
  russian,
  portuguese,
  arabic
}

enum FirstDayOfWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday
}

final List<String> dateFormats = [
  'MM/dd/yyyy',
  'dd/MM/yyyy',
  'dd-MM-yyyy',
  'yyyy-MM-dd',
];

final List<String> numberFormats = [
  '1,234.00',
  '1,234',
];
