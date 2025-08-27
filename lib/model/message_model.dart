class MessageModel {
  String? msg;
  int? sendId;

  String? sendAt;
  bool? isRead;

  MessageModel({
    required this.msg,
    required this.sendId,
    required this.sendAt,
    this.isRead = false,
  });
}
