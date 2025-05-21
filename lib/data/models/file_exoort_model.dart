class FileExportModel {
  int? statusCode;
  var status;
  String? message;
  bool? isDownload;
  String? downloadUrl;
  FileExportDataModel? data;

  FileExportModel(
      {this.statusCode,
      this.status,
      this.message,
      this.data,
      this.isDownload,
      this.downloadUrl});

  FileExportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    isDownload = json['is_download'];
    downloadUrl = json['download_url'];
    data = json['data'] != null
        ? new FileExportDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    data['is_download'] = this.isDownload;
    data['download_url'] = this.downloadUrl;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FileExportDataModel {
  String? fileName;

  FileExportDataModel({this.fileName});

  FileExportDataModel.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = this.fileName;
    return data;
  }
}
