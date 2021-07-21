class Todo{
  final int content1;
  final String content2;
  final String content3;
  final String content4;
  final String content5;

  Todo(this.content1, this.content2, this.content3,
      this.content4, this.content5);

  Todo.fromJson(Map data)
  : content1 = data['content1'],
        content2 = data['content2'],
        content3 = data['content3'],
        content4 = data['content4'],
        content5 = data['content5'];

  Map<String, dynamic> toTodo() {
    return {
      'content1' : content1,
      'content2' : content2,
      'content3' : content3,
      'content4' : content4,
      'content5' : content5,
    };
  }
}