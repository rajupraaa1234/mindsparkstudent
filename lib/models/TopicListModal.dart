import 'dart:convert';

class TopicListModal{
  final String name;
  final String id;

  TopicListModal(this.name, this.id);


  factory TopicListModal.fromJson(dynamic json) {
    return TopicListModal(json['name'] as String, json['id']);
  }

  static Map<String, dynamic> toMap(TopicListModal topicListModal) => {
    'name': topicListModal.name,
    'id': topicListModal.id,
  };


  static String encode(List<TopicListModal> list) => json.encode(
    list
        .map<Map<String, dynamic>>((list) => TopicListModal.toMap(list))
        .toList(),
  );

  static List<TopicListModal> decode(String mcq) =>
      (json.decode(mcq) as List<dynamic>)
          .map<TopicListModal>((item) => TopicListModal.fromJson(item))
          .toList();
}