final String mainTitle = 'Produkty regionalne';
final String mainDescription =
    'Wybierz województwo aby wyświetlić produkty regionalne dla tego obszaru.';

List<String> provinceList = [
  'dolnośląskie',
  'kujawsko-pomorskie',
  'lubelskie',
  'łódzkie',
  'lubuskie',
  'małopolskie',
  'mazowieckie',
  'opolskie',
  'podkarpackie',
  'podlaskie',
  'pomorskie',
  'śląskie',
  'świętokrzyskie',
  'warmińsko-mazurskie',
  'wielkopolskie',
  'zachodniopomorskie'
];

List<String> categoryList = [
  'Produkty mleczne',
  'Produkty mięsne',
  'Produkty rybołówstwa',
  'Warzywa i owoce',
  'Wyroby piekarnicze i cukiernicze',
  'Oleje i tłuszcze',
  'Miody',
  'Gotowe dania i potrawy',
  'Napoje',
  'Inne produkty',
];

List<String> categoryListSmall = [
  'produkty mleczne',
  'produkty mięsne',
  'produkty rybołówstwa',
  'warzywa i owoce',
  'wyroby piekarnicze i cukiernicze',
  'oleje i tłuszcze',
  'miody',
  'gotowe dania i potrawy',
  'napoje',
  'inne produkty',
];

List<String> categoryListForDownload = [
  'produkty_mleczne',
  'produkty_miesne',
  'produkty_rybolowstwa',
  'warzywa_i_owoce',
  'wyroby_piekarnicze_i_cukiernicze',
  'oleje_i_tluszcze',
  'miody',
  'gotowe_dania_i_potrawy',
  'napoje',
  'inne_produkty',
];

List<String> detailTitles = [
  'Nazwa',
  'Wygląd',
  'Kształt',
  'Rozmiar',
  'Kolor',
  'Konsystencja',
  'Smak',
  'Inne informacje',
  'Tradycja'
];

String removePolishChars(String fromWhat) {
  String toWhat = fromWhat
      .replaceAll('ą', 'a')
      .replaceAll('ć', 'c')
      .replaceAll('ę', 'e')
      .replaceAll('ł', 'l')
      .replaceAll('ń', 'n')
      .replaceAll('ó', 'o')
      .replaceAll('ś', 's')
      .replaceAll('ż', 'z')
      .replaceAll('ź', 'z');

  return toWhat;
}
