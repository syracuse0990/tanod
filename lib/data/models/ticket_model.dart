class TicketModel {
  var statusCode;
  var status;
  var message;
  TicketDataModel? data;

  TicketModel({this.statusCode, this.status, this.message, this.data});

  TicketModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new TicketDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TicketDataModel {
  List<TicketDetailModel>? tickets;
  var pageNo;
  var totalEntries;
  var totalPages;

  TicketDataModel(
      {this.tickets, this.pageNo, this.totalEntries, this.totalPages});

  TicketDataModel.fromJson(Map<String, dynamic> json) {
    if (json['tickets'] != null) {
      tickets = <TicketDetailModel>[];
      json['tickets'].forEach((v) {
        tickets!.add(new TicketDetailModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class TicketDetailModel {
  var id;
  var title;
  var description;
  var conclusion;
  var typeId;
  var stateId;
  var createdAt;
  var updatedAt;
  var createdBy;

  TicketDetailModel(
      {this.id,
      this.title,
      this.description,
      this.conclusion,
      this.typeId,
      this.stateId,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  TicketDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    conclusion = json['conclusion'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['conclusion'] = this.conclusion;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}
