class TopicListModal{
  final String name;
  final String id;

  TopicListModal(this.name, this.id);


  factory TopicListModal.fromJson(dynamic json) {
    return TopicListModal(json['name'] as String, json['id']);
  }
}