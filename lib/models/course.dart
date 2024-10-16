class Course {
  //attributes = fields in table
  int? _id;
  String? _name;
  String? _content;
  int? _hours;
  String? _level;
  int? _price;
  Course(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _content = obj['content'];
    _hours = obj['hours'];
    _level = obj['level'];
    _price = obj['price'];
  }
  Course.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _content = data['content'];
    _hours = data['hours'];
    _level = data['level'];
    _price = data['price'];
  }

  //methods
  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'content': _content,
        'hours': _hours,
        'level': _level,
        'price': _price,
      };

  //getters
  int? get id => _id;
  String? get name => _name;
  String? get content => _content;
  int? get hours => _hours;
  String? get level => _level;
  int? get price => _price;
}
