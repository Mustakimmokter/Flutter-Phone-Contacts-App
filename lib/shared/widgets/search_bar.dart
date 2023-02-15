
import 'package:flutter/material.dart';
import 'package:phone_contact_app/features/details/ui/screen/update_screen.dart';
import 'package:phone_contact_app/shared/models/contact_info.dart';
import 'package:phone_contact_app/shared/widgets/index.dart';

/*class SearchBar {
  static final List<String> numberList = [
    '01779 - 403901',
    '01779 - 403902',
    '01779 - 403903',
    '01779 - 403904',
    '01779 - 403905',
    '01779 - 403906',
    '01779 - 403907',
    '01779 - 403908',
    '01779 - 403909',
    '01779 - 403910',
    '01779 - 403911',
    '01779 - 403912',
    '01779 - 403913',
    '01779 - 403914',
    '01779 - 403915'
  ];
  static List<String> nameList = [
    'Saddam',
    'Jowel',
    'Mishu',
    'Saiful',
    'Rubel',
    'Nayeem',
    'Rayhan',
    'Ashik',
    'Khairul',
    'Khurshed',
    'Fahad',
    'Shihab',
    'Ruman',
    'Onik',
    'Safayet'
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(nameList);
    matches.retainWhere(
        (name) => name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}*/

class DataSearch extends SearchDelegate<String> {
  DataSearch({required this.contactList});
  final List<ContactInfo> contactList;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    //final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey.shade50,
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
          elevation: 0,
          toolbarHeight: 65,
          shadowColor: Colors.grey.shade50,
          toolbarTextStyle: theme.textTheme.bodyText2,
          titleTextStyle: theme.textTheme.headline6),
      backgroundColor: Colors.blueGrey.shade50,
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            border: InputBorder.none,
          ),
    );
  }

  @override
  TextStyle? get searchFieldStyle {
    return const TextStyle(fontWeight: FontWeight.normal);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ContactInfo> matches = [];
   for(ContactInfo contactInfo in contactList){
     if(contactInfo.name!.toLowerCase().contains(query.toLowerCase())){
       matches.add(contactInfo);
     }
   }
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) => ListTile(
        title: ContactDetails(
          call: () {},
          name: matches[index].name!,
          number: matches[index].number!,
          avatar: matches[index].name![0],
          onTapOne: () {},
          onTapTwo: () {},
        ),
      ),
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<ContactInfo> matches = [];
    for(ContactInfo contactInfo in contactList){
      if(contactInfo.name!.toLowerCase().contains(query.toLowerCase())){
        matches.add(contactInfo);
      }
    }
    return ListView.builder(
        itemCount: matches.isNotEmpty ? matches.length : 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: ContactDetails(
              call: () {},
              name: matches[index].name!,
              number: matches[index].number!,
              avatar: matches[index].name![0],
              onTapOne: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(
                      name: matches[index].name!,
                      number: matches[index].number!,
                    ),
                  ),
                );
              },
              onTapTwo: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(
                      name: matches[index].name!,
                      number: matches[index].number!,
                    ),
                  ),
                );
              },
            ),
          );
        });
  }


  @override
  Widget showResults(BuildContext context) {
    super.showResults(context);
    List<ContactInfo> matches = [];

    for(ContactInfo contactInfo in contactList){
      if(contactInfo.name!.toLowerCase().contains(query.toLowerCase())){
        matches.add(contactInfo);
      }
    }

    return ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) => ListTile(
        title: ContactDetails(
          call: () {},
          name: matches[index].name!,
          number: matches[index].number!,
          avatar: matches[index].name![0],
          onTapOne: () {},
          onTapTwo: () {},
        ),
      ),
    );
  }


 /* @override
  Widget showResults(BuildContext context) {
    super.showResults(context);
    List<ContactInfo> matches = [];
    matches.addAll(contactList);
    matches.retainWhere((contactInfo) =>
        contactInfo.name!.toLowerCase().contains(query.toLowerCase()));
    return matches.isNotEmpty && matches != null? ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) => ListTile(
        title: ContactDetails(
          call: () {},
          name: matches[index].name!,
          number: matches[index].number!,
          avatar: matches[index].name![0],
          onTapOne: () {},
          onTapTwo: () {},
        ),
      ),
    ) :
    const Center(child: CustomTextOne(text: 'Search Not Matched'));
  }*/
}
