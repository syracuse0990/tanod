import 'dart:io';

import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/add_tractor_model.dart';
import '../../../models/file_exoort_model.dart';
import '../../../models/tratcor_model.dart';

abstract class ITractorRepository {
  Future<TractorDataModel> getAllTractorList({map}) {
    throw UnimplementedError();
  }

  Future<AddTractorModel> getTractorDetails({map}) {
    throw UnimplementedError();
  }

  Future<AddTractorModel> downloadImportFile( ) {
    throw UnimplementedError();
  }

  Future<AddTractorModel> uploadImportFile({formData}) {
    throw UnimplementedError();
  }

  Future<AddTractorModel> addNewTractor({map,List<File> ?listImage}) {
    throw UnimplementedError();
  }

  Future<AddTractorModel> updateTractor({map, List<File>? listImage}) {
    throw UnimplementedError();
  }


  Future<SuccessModel> deleteTractors({map}) {
    throw UnimplementedError();
  }


  Future<FileExportModel> exportReports({map}) {
    throw UnimplementedError();
  }

  Future<FileExportModel> exportReportsFileExists({map}) {
    throw UnimplementedError();
  }
}
