import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passmanager/src/model/password/response_mode.dart';
import 'package:passmanager/src/services/services.dart';
import 'package:passmanager/src/widget/alert/custom_dialog.dart';

import 'components/index_info_section.dart';
import 'components/index_section.dart';
import 'components/save_pass_section.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  onBack() async {
    SystemNavigator.pop(animated: true);
  }

  late List<PassResponseModel> passList = [];
  set getPassList(List<PassResponseModel> value) {
    passList = value;
    setState(() {});
  }

  getData() async {
    String contact = await GetAllPref.contactNumber();
    await GSheetConnection.getPasswordByContactNumber(
      phoneNumber: contact,
    ).then((value) {
      getPassList = value;
    }).onError((error, stackTrace) {
      getPassList = [];
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("INDEX"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async {
                await getData();
              },
              icon: const Icon(Icons.sync),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AndroidAlertDialog(
              "Save New Password",
              child: const SavePasswordSection(),
            ).show(context);
          },
          child: const Icon(Icons.add),
        ),
        body: passList.isNotEmpty
            ? ListView.builder(
                itemCount: passList.length,
                itemBuilder: (context, index) {
                  PassResponseModel indexData = passList[index];
                  return ListWidget(
                    platfrom: indexData.platfrom,
                    password: indexData.password,
                    updateDate: "",
                    createDate: indexData.createdDate,
                    onTap: () {
                      AndroidAlertDialog(
                        "View Password",
                        child: IndexDataWidget(data: indexData),
                      ).show(context);
                    },
                  );
                },
              )
            : const Center(
                child: Text(
                  "Password Not Saved. Please add your password.",
                ),
              ),
      ),
    );
  }
}
