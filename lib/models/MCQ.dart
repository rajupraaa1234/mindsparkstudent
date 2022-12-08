
class MCQ{


  final String question_seq;
  final String question_body;
  final String question_type;
  final String question_options;
  final String mcq_1;
  final String mcq_2;
  final String mcq_3;
  final String mcq_4;
  final String question_inst;
  final String question_voice;
  final String correct;
  final String question_desc;
  final String question_image;

  MCQ(
      this.question_seq,
      this.question_body,
      this.question_type,
      this.question_options,
      this.mcq_1,
      this.mcq_2,
      this.mcq_3,
      this.mcq_4,
      this.question_inst,
      this.question_voice,
      this.correct, this.question_desc, this.question_image);

  factory MCQ.fromJson(dynamic json) {
    return MCQ(
        json['question_seq'] as String,
        json['question_body'] as String,
        json['question_type'] as String,
        json['question_options'] as String,
        json['mcq_1'] as String,
        json['mcq_2'] as String,
        json['mcq_3'] as String,
        json['mcq_4'] as String,
        json['question_inst'] as String,
        json['question_voice'] as String,
        json['correct'] as String,
        json['question_desc'] as String,
        json['question_image'] as String
    );
  }

}