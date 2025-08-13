class APIEndpoint {
  static String get local => 'https://tanodtractor.com/api/user/';

  // static String get remote => 'https://tanod-tractor.iapplabz.co.in/api/user/';
 static String get remote => 'https://tanodtractor.com/api/user/';
  // static String get remote =>
  //     'https://tanod-tractor-demo.iapplabz.co.in/api/user/';

  static String get localImageUrl => 'https://tanodtractor.com/storage/';

  static String get remoteImageUrl => 'https://tanodtractor.com/storage/';

  static String get baseUrl => local;

  static String get imageUrl => localImageUrl;

  static String get login => "login";

  static String get signUp => "register";

  static String get otp => "send-otp";
  static String get sendMobileOtp => "send-mobile-otp";

  static String get verifyMobileOtp => "verify-otp";

  static String get groupList => "group-list";

  static String get deviceList => "device-list";

  static String get deviceLists => "device-lists";
  static String get farmerLists => "farmers";
  

  static String get userDetail => "details";

  static String get createBookingUrl => "create-tractor-booking";

  static String get bookingListUrl => "booking-list";

  static String get bookingDetailUrl => "tractor-booking-detail";

  static String get farmerListUrl => "user-list";

  static String get deleteGroupUrl => "delete-group";

  static String get tractorDetailUrl => "tractor-detail";

  static String get createGroupUrl => "create-group";

  static String get createDeviceUrl => "create-device";

  static String get deviceDetailsUrl => "device-detail";

  static String get updateDeviceUrl => "update-device";

  static String get deleteDeviceUrl => "delete-device";

  static String get tractorList => "tractor-list";

  static String get createTractorUrl => "create-tractor";

  static String get deleteTractorsUrl => "delete-tractor";

  static String get tractorDetailsUrl => "tractor-detail";

  static String get downloadImportFile => "farmer-import-format";

  static String get uploadImportFile => "farmer-import";

  static String get updateTractorUrl => "update-tractor";

  static String get adminAllBookingUrl => "all-bookings";
  static String get tractorBookingsUrl => "tractor-booking-list";

  static String get changeBookingStatusUrl => "change-status";

  static String get groupDetailUrl => "group-detail";

  static String get updateGroupUrl => "update-group";

  static String get updateProfileUrl => "update-profile";

  static String get logoutApiUrl => "logout";

  static String get forgotPasswordUrl => "forgot-password";

  static String get issueList => "issue-type-list";

  static String get createNewIssue => "create-issue-type";

  static String get issueTypeDetails => "issue-type-detail";

  static String get deleteIssueTitle => "delete-issue-type";

  static String get updateIssueUrl => "update-issue-type";

  static String get createFeedback => "create-feedback";

  static String get updateFeedback => "update-feedback";

  static String get feedbackList => "feedback-list";

  static String get acceptedBookingList => "accepted-bookings";

  static String get deviceLocation => "device-location";

  static String get deviceBasedBooking => "device-booking-list";

  static String get deviceTrackUrl => "device-track-data";

  static String get updatedLatLngUrl => "device-location";

  static String get feedbackDetails => "feedback-detail";

  static String get addConclusion => "conclusion";

  static String get maintenanceList => "maintenance-list";

  static String get createMaintenance => "create-maintenance";

  static String get updateMaintenance => "update-maintenance";

  static String get deleteMaintenance => "delete-maintenance";

  static String get maintenanceDetails => "maintenance-detail";

  static String get changeMaintenanceState => "change-maintenance-state";

  static String get addMaintenanceConclusion => "update-conclusion";

    static String get addTractor => "add-tractor";

  //admin can send conclusion to farmer
  static String get conclusion => "conclusion";

  static String get maintenanceTractorList => "maintenance-tractor-list";
  static String get geoFenceImeiData => "geo-fence-imei-data";

  static String get maintenanceFilter => "filter";

  static String get userList => "user-list";

  static String get deleteUser => "delete-user";

  static String get userDetails => "user-detail";
  static String get userUpdate => "user-update";
  static String get geoFenceList => "geo-fence-list";
  static String get deleteGeoFence => "delete-geo-fence";
  static String get detailGeoFence => "geo-fence-detail";
  static String get createGeoFence => "create-geo-fence";
  static String get updateGeoFence => "update-geo-fence";
  static String get getDeviceListState => "get-device-list";

  static String get pageList => "page-list";
  static String get deletePage => "delete-page";
  static String get pageDetails => "page-detail";
  static String get updatePage => "update-page";

  static String get alertList => "alert-list";
  static String get alertBaseOnImei => "alerts-list";

  static String get exportTractorReport => "export-report";
  static String get exportTractorReportExits => "download-report";

  //todo for sub admin
  static String get createSubAdmin => "create-sub-admin";
  static String get updateSubAdmin => "update-sub-admin";
  static String get assignGroups => "assign-groups";
  static String get assignGroupToSubAdmin => "assign-group";

  //raise ticket api
  static String get ticketListUrl => "get-tickets";
  static String get createTicketUrl => "create-ticket";
  static String get updateTicketUrl => "update-ticket";
  static String get ticketDetailUrl => "ticket-detail";
  static String get ticketDeleteUrl => "delete-ticket";

  // new api for home screen
  static String get homeDeviceAPI => "getDevices";
  static String get deviceTrackApi => "device-track-data";

  static int userRole = 2;
  static int aminRole = 0;
  static int subAdminRole = 3;
  static int technicianRole = 4;

  static int stateAccepted = 3;
  static int stateCompleted = 2;

  static int stateActive = 1;
  static int stateClosed = 3;

  static int stateRejected = 4;

  static int normalMapType = 1;
  static int otherMapType = 2;

  static int stateDocumentation = 1;
  static int stateFilled = 2;
  static int stateInProgress = 3;
  static int statesCompleted = 4;
  static int statesCancelled = 5;

  static int male = 0;
  static int female = 1;

  static int termsAndCondition = 1;
  static int privacyPolicy = 2;

  static var typeMaintenance = "1";
  static var typeEnterGeoFence = "2";
  static var typeExitGeofence = "3";

  static var exportTractors = 1;
  static var exportFeedback = 2;
  static var exportDevice = 3;
  static var exportGroup = 5;

  static var assignToSubAdmin = 1;
  static var unAssignToSubAdmin = 2;

  // ignore: non_constant_identifier_names
  static var ACC_OFF = 1001;
  // ignore: non_constant_identifier_names
  static var ACC_ON = 1002;
  // ignore: non_constant_identifier_names
  static var GEOZONE_IN = 1006;
  // ignore: non_constant_identifier_names
  static var GEOZONE_OUT = 1007;
}
