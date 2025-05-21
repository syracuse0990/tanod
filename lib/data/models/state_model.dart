class StateModel {
  int? stateId;
  String? title;
  bool? isSelected=false;

  StateModel({this.stateId, this
  .isSelected=false,this.title});

  StateModel.fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateId'] = this.stateId;
    data['title'] = this.title;
    return data;
  }
}
