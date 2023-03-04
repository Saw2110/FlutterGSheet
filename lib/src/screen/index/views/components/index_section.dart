import 'package:flutter/material.dart';
import 'package:passmanager/src/theme/theme.dart';

class ListWidget extends StatelessWidget {
  final String platfrom, password, updateDate, createDate;
  final Function onTap;
  const ListWidget({
    super.key,
    required this.platfrom,
    required this.password,
    required this.updateDate,
    required this.createDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.decoration(),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(platfrom,
                  style: kLoginTitleTextStyle.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Text('Updated: $updateDate'),
                  const SizedBox(width: 16.0),
                  Text('Created: $createDate'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text('Pass Text: XXXXXX'),
            ],
          ),
        ),
      ),
    );
  }
}
