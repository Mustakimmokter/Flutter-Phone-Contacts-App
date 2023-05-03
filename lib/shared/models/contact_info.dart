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
    this.isSelected = false,
    this.avatar,
    this.name,
    this.number,
  });
  final bool? isSelected;
  final String? avatar, name, number;
}
