import 'package:tanod_tractor/data/models/admin_booking_model.dart';
import 'package:tanod_tractor/data/models/tractor_group_model.dart';

class MaintenanceDetailModel {
  int? id;
  var tractorIds;
  String? maintenanceDate;
  String? techName;
  String? techEmail;
  String? techNumber;
  var conclusion;
  int? stateId;
  var createdAt;
  String? updatedAt;
  CreatedByModel? createdBy;
  TractorModel? tractor;

  MaintenanceDetailModel(
      {this.id,
      this.tractorIds,
      this.maintenanceDate,
      this.techName,
      this.techEmail,
      this.techNumber,
      this.stateId,
      this.conclusion,
      this.createdBy,
      this.updatedAt,
      this.createdAt,
      this.tractor});

  MaintenanceDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tractorIds = json['tractor_ids'];
    maintenanceDate = json['maintenance_date'];
    techName = json['tech_name'];
    techEmail = json['tech_email'];
    techNumber = json['tech_number'];
    stateId = json['state_id'];
    conclusion = json['conclusion'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedByModel.fromJson(json['created_by'])
        : null;
    tractor =
        json['tractor'] != null ? new TractorModel.fromJson(json['tractor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tractor_ids'] = this.tractorIds;
    data['maintenance_date'] = this.maintenanceDate;
    data['tech_name'] = this.techName;
    data['tech_email'] = this.techEmail;
    data['tech_number'] = this.techNumber;
    data['state_id'] = this.stateId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['conclusion'] = this.conclusion;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    if (this.tractor != null) {
      data['tractor'] = this.tractor!.toJson();
    }
    return data;
  }
}





