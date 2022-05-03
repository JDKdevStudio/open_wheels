import 'package:flutter/material.dart';
import 'package:open_wheels/classes/classes.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return item is UserData ? _UserCard(item: item) : _CarCard(item: item);
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final UserData item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.avatar!),
        ),
        title: Text('${item.name} ${item.surname}'),
        subtitle: Text(item.email!),
        trailing: const Icon(Icons.person_outline_outlined),
        onTap: () => Navigator.pushNamed(context, 'profile', arguments: item),
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  const _CarCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Car item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.photo!),
        ),
        title: Text(item.placa!),
        subtitle: Text(item.user!),
        trailing: const Icon(Icons.directions_car_outlined),
        onTap: () => Navigator.pushNamed(context, 'car_info', arguments: item),
      ),
    );
  }
}
