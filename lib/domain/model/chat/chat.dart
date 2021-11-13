import 'package:equatable/equatable.dart';
import 'package:tinder/domain/model/user/user.dart';
import 'package:tinder/dto/chat/chat_response_dto.dart';

class Chat extends Equatable {
  final String id;
  final User user;
  final User match;
  // TODO: Implement last message on firestore
  // final Message? mostRecentMessage;

  const Chat({
    required this.id,
    required this.user,
    required this.match,
    // required this.mostRecentMessage,
  });

  factory Chat.fromDto(ChatResponseDTO dto, String userUid) => Chat(
        id: dto.id!,
        user: User.fromDto(dto.chatters.chatters.firstWhere(
          (element) => element.uid == userUid,
        )),
        match: User.fromDto(dto.chatters.chatters.firstWhere(
          (element) => element.uid != userUid,
        )),
      );

  @override
  List<Object?> get props => [
        id,
        user,
        match,
        // mostRecentMessage,
      ];
}
