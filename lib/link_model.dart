class Link {
  int? id;
  String? link;
  String? nameLink;

  Link({this.id, this.nameLink, this.link});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'link' : link, 
      'nameLink': nameLink,
    };
  }

  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
      id: map['id'],
      link: map['link'],
      nameLink: map['nameLink'],
    );
  }
}
