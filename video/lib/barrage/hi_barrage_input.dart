import 'package:flutter/material.dart';
import 'package:video/util/color.dart';
import 'package:video/util/view_util.dart';

class HiBarrageInput extends StatelessWidget {
  final VoidCallback? onTapClose;
  const HiBarrageInput({Key? key, this.onTapClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (onTapClose != null) {
                  onTapClose!();
                }
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          //加这个safearea，上面的container会和这个safearea产生一个大间隙
          SafeArea(
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  hiSpace(width: 15),
                  _input(editingController, context),
                  _sendButton(editingController, context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _input(TextEditingController editingController, BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: TextField(
          autofocus: true,
          controller: editingController,
          onSubmitted: (text) {
            _send(text, context);
          },
          cursorColor: primary,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
            hintText: "发送弹幕",
          ),
        ),
      ),
    );
  }

  _sendButton(TextEditingController editingController, BuildContext context) {
    return GestureDetector(
      onTap: () {
        var text = editingController.text.trim();
        _send(text, context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.send_sharp,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _send(String text, BuildContext context) {
    if (text.isNotEmpty) {
      if (onTapClose != null) {
        onTapClose!();
      }
      Navigator.of(context).pop(text);
    }
  }
}
