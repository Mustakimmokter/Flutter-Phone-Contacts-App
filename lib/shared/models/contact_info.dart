class Contacts {
  Contacts({
    this.isSelected = false,
    this.id = '33434',
    this.name = 'mustakim',
    this.number = '01779-504864',
  });

  late bool isSelected;
  final String?  name, number;
  final String? id;
}

class ContactInfoModel {
  const ContactInfoModel({
    this.isFavorite = false,
    this.id,
    this.name,
    this.number,
  });
  final bool? isFavorite;
  final String? name, number;
  final String? id;
}
