import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/services/user_services/user_service.dart';
import 'package:phone_contact_app/shared/widgets/contact_details.dart';
import 'package:provider/provider.dart';

class SearchBuild extends StatelessWidget {
  const SearchBuild({super.key, required this.matches});
  final List<dynamic> matches;

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context,listen: false);
    return ListView.builder(
      itemCount: matches.isNotEmpty ? matches.length : 0,
      itemBuilder: (context, index) => ListTile(
        title: ContactDetails(
          avatar: matches[index]['name'][0],
          name: matches[index]['name'],
          number: matches[index]['number'],
          isFavorite: matches[index]['isFavorite'],
          avatarOnTap: () {
            final params = {
              'name': matches[index]['name'],
              'number':matches[index]['number'],
              'id': matches[index]['id']
            };
            Navigator.pushNamed(context, '/detailsScreen',arguments: params);
          },
          // LongPress Button
          onLongPress: (){
            userService.shareContact(matches[index]['number']);
          },
          // Collapse Button
          collapsePressed: () {
            final params = {
              'name': matches[index]['name'],
              'number':matches[index]['number'],
              'id': matches[index]['id']
            };
            Navigator.pushNamed(context, '/detailsScreen',arguments: params);
          },
          // Favorite Button
          favorite: (){
          },
          // Call Button
          call: () {
            userService.phoneCallDialer(matches[index]['number']);
          },
        ),
      ),
    );
  }
}
