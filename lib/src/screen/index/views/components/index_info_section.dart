import 'package:flutter/material.dart';
import 'package:passmanager/src/model/password/response_mode.dart';
import 'package:passmanager/src/theme/theme.dart';
import 'package:passmanager/src/utils/utils.dart';
import 'package:passmanager/src/widget/widget.dart';

class IndexDataWidget extends StatefulWidget {
  final PassResponseModel data;
  const IndexDataWidget({super.key, required this.data});

  @override
  State<IndexDataWidget> createState() => _IndexDataWidgetState();
}

class _IndexDataWidgetState extends State<IndexDataWidget> {
  bool isShow = false;
  set getShowPass(bool value) {
    isShow = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    PassResponseModel data = widget.data;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "PLATFROM",
          style: kSubTextStyle.copyWith(fontSize: 16.0),
        ),
        Text(
          "↳ ${data.platfrom}",
          style: kSubTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).pl(10),

        const SizedBox(height: 10.0),
        Text(
          "PASSWORD",
          style: kSubTextStyle.copyWith(fontSize: 16.0),
        ),
        Text(
          isShow ? "↳ ${data.password}" : "↳ XXXXXX",
          style: kSubTextStyle.copyWith(color: Colors.redAccent),
        ).pl(10),

        ///
        verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextButton(
                onPressed: () {
                  if (isShow) {
                    getShowPass = false;
                  } else {
                    getShowPass = true;
                  }
                  setState(() {});
                },
                child: const Text("VIEW PASSWORD"),
              ),
            ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CLOSE"),
              ),
            ),
          ],
        ),
        verticalSpace(),
      ],
    ).p(15.0, 0.0, 10.0, 0.0);
  }
}
