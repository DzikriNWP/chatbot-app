import 'package:chat_bot_app/data/api_helper.dart';
import 'package:chat_bot_app/model/gemini_response_model.dart';
import 'package:chat_bot_app/model/message_model.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageModel> listMessage = [];
  sendMessage({required String message}) async {
    try {
      var mData = await ApiHelper().sendMsgApi(msg: message);
      listMessage.insert(
        0,
        MessageModel(
          msg: message,
          sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
          sendId: 0,
        ),
      );

      GeminiResponseModel geminiResponseModel = GeminiResponseModel.fromJson(
        mData,
      );
      listMessage.insert(
        0,
        MessageModel(
          msg: geminiResponseModel.candidates![0].content!.parts![0].text,
          sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
          sendId: 1,
        ),
      );
      notifyListeners();
    } catch (e) {
      listMessage.insert(
        0,
        MessageModel(
          msg: e.toString(),
          sendAt: DateTime.now().millisecondsSinceEpoch.toString(),
          sendId: 1,
        ),
      );
      notifyListeners();
    }
  }

  fetchAllMessage() {
    return listMessage;
  }

  void updateMessageRead(int index) {
    listMessage[index].isRead = true;
  }
}
