import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memoapp/utilities/dependencies.dart' as dependencies;
import 'package:memoapp/dialogs/add_memo_dialog.dart';
import 'package:memoapp/dialogs/delete_memo_dialog.dart';
import 'package:memoapp/dialogs/sign_out_dialog.dart';
import 'package:intl/intl.dart';

class MemoCard extends StatelessWidget {
  final String timeStamp;
  final String content;
  final int index;
  final Function scrollToBottom;

  const MemoCard({
    required this.timeStamp,
    required this.content,
    required this.index,
    required this.scrollToBottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.white,
      elevation: 5,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.yMEd().add_jm().format(
                        DateTime.parse(timeStamp).add(
                          const Duration(hours: 3),
                        ),
                      ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteMemoDialog(
                          index: index,
                          scrollToBottom: scrollToBottom,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            Text(content), // Correctly displaying the memo content
          ],
        ),
      ),
    );
  }
}

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  var memoController = TextEditingController();
  RxString status = 'type-memo'.obs;
  var scrollController = ScrollController();

  void scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.find<dependencies.AuthController>().memos.isNotEmpty) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: const Row(
                children: [
                  Text('Sign Out'),
                  SizedBox(width: 10),
                  Icon(Icons.logout),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const SignOutDialog();
                  },
                );
              },
            ),
          ),
        ],
        title: Center(
          child:
              Text(Get.find<dependencies.AuthController>().SignedInEmail.value),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1,
                colors: [
                  Colors.white,
                  Color(0xff5debd7),
                  Colors.white,
                ],
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Obx(
                () => Get.find<dependencies.AuthController>().memos.isEmpty
                    ? const Center(
                        child: Text('No memos yet'),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 130,
                        ),
                        itemCount: Get.find<dependencies.AuthController>()
                            .memos
                            .length,
                        itemBuilder: (context, index) {
                          return MemoCard(
                            timeStamp: Get.find<dependencies.AuthController>()
                                .memos[index]['timeStamp'],
                            content: Get.find<dependencies.AuthController>()
                                .memos[index]['content'],
                            index: index,
                            scrollToBottom: scrollToBottom,
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          bottom: 20,
        ),
        child: IconButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.white,
            ),
            foregroundColor: MaterialStatePropertyAll(
              Colors.black,
            ),
          ),
          icon: const Icon(
            Icons.add,
            size: 50,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddMemoDialog(
                  scrollToBottom: scrollToBottom,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
