import 'package:tanod_tractor/data/models/admin_booking_model.dart';

class StaticPageDataModel {
  var id;
  var title;
  var description;
  var pageType;
  var stateId;
  var  typeId;
  var createdAt;
  var updatedAt;
  CreatedByModel? createdBy;

  StaticPageDataModel(
      {this.id,
        this.title,
        this.description,
        this.pageType,
        this.stateId,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.createdBy});

  StaticPageDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    pageType = json['page_type'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedByModel.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['page_type'] = this.pageType;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    return data;
  }
}