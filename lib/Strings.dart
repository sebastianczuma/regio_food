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

  print(toWhat);
  return toWhat;
}
