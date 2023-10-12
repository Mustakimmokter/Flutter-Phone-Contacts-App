class Contacts {
  Contacts({
    this.isSelected = false,
    this.avatar = 'a',
    this.name = 'mustakim',
    this.number = '01779-504864',
  });

  late bool isSelected;
  final String? avatar, name, number;
}

class ContactInfoModel {
  const ContactInfoModel({
    this.isFavorite = false,
    this.avatar,
    this.name,
    this.number,
  });
  final bool? isFavorite;
  final String? avatar, name, number;
}
