class BookReview {
  String? user;
  String? content;
  int? stars;
  String? dateAdded;
  int? pk;

  BookReview({this.user, this.content, this.stars, this.dateAdded});

  BookReview.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    content = json['content'];
    stars = json['stars'];
    dateAdded = json['date_added'];
    pk = json['pk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['content'] = this.content;
    data['stars'] = this.stars;
    data['date_added'] = this.dateAdded;
    return data;
  }
}
