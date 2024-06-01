
class Nota {
  String texto = "";
  String path = "";
  var tags = <String>[];
  void addTag(String tag) {
    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }
  }

  String getTags() {
    return tags.join('|');
  }

  @override
  String toString() {
    return '$texto tags: $tags | ';
  }

  String aStringParaGuardar() {
    String r = '{"texto": "$texto" ,';
    r += '"path": "$path" ,';
    r += '"tags":[';
    for (String t in tags) {
      r += '"$t"';
      if (t != tags[tags.length - 1]) {
        r += ",";
      }
    }
    r += ']}';

    return r;
  }
}