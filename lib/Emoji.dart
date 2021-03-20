class Emoji {
  String emoji;
  String name;
  String description;
  int id;

  Emoji({this.emoji, this.name, this.description, this.id});

  static List<Emoji> emojiListfromJson(json) {
    List<Emoji> emoji = [];

    for (var obj in json) {
      emoji.add(new Emoji(
          emoji: obj['emoji'],
          name: obj['name'],
          id: obj['id'],
          description: obj['description']));
    }
    return emoji;
  }
}
