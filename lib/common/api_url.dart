import 'package:adam_company_consumer_app/common/import_clases.dart';

var production_base_url = "http://socialenginespecialist.com/PuneDC/adamcompanies/api";
var base_url = "https://www.adamcompanies.com:8008/api";
var generate_otp = "$base_url/auth/generate_OTP";
var social_media_insert = "$base_url/auth/socialsignup";
var add_profile = "$base_url/auth/signup";
var get_services = "$base_url/techservices/getservices";
var customer_service = "$base_url/customermanagement/consumerservicerequest";
var ongoing_services =
    "$base_url/customermanagement/ongoingconsumerservicerequest";
var completed_services =
    "$base_url/customermanagement/completedconsumerservicerequest";
var get_rejected_service = "$base_url/jobdetails/jobrejectedjob?consumer_id=";
var get_requested_services =
    "$base_url/jobdetails/jobRequestsByConsumer?consumer_id=";
var technician_profile = "$base_url/technicianprofile/getnearbytechnician";
var technician_profile_comment =
    "$base_url/technicianprofile/gettechnicianreviewrating";
var technician_profile_img =
    "https://adamcompanies.com:8008/public/public/uploads/tech_profile_image";
var service_img =
    "https://adamcompanies.com:8008/public/public/uploads/education_document";
var get_consumer_profile = "$base_url/customermanagement/getcutomerporfile";
var update_consumer_profile =
    "$base_url/customermanagement/updatecutomerporfile";
var get_active_banner = "$base_url/banner/getCountryWiseActiveBanner";
var get_best_offers = "$base_url/offer/getCountryWiseActiveOffer";
var privacy_policy = "$base_url/auth/privacy_policy";
var about_us = "$base_url/auth/aboutus";
var help = "$base_url/auth/help";
var get_ongoing_technician =
    "$base_url/customermanagement/techniciandetailsongoingconsumerservices";
var contact_technician = "$base_url/techservices/technician_contact_us";
var get_notification = "$base_url/customermanagement/getnotificationByuser";
var get_graph_data =
    "$base_url/technicianprofile/getReviewPercentage?technician_id=";
var get_payment_details = "$base_url/payment/getpaymentdetails";
var make_payment = "$base_url/payment/makepayment";
var add_notificatio = "$base_url/auth/onoffnotification";
var get_notificatio = "$base_url/auth/getnotificatoinstaus?user_id=";
var get_partenrs_logo = "$base_url/banner/getsponserbannerimages";
var save_payment_details = "$base_url/payment/savepaymentdetails";
var get_main_service_category = "$base_url/techservices/getcategories";
var get_sub_services = "$base_url/techservices/getcategoryservices?category=";
var update_token = "$base_url/auth/updatemobiletoken";
var check_stripe_token = "$base_url/payment/checkstripetoken";
var save_stripe_details = "$base_url/payment/savestripedetails";
var delete_stripe_details = "$base_url/payment/removestripecarddetails";
var get_stripe_details = "$base_url/payment/getpayment";
var update_payment = "$base_url/payment/updatepaymentdetails";
var quotation_detail =
    "$base_url/quotation/getquotationapprveddetail?service_requsted_id=";
var update_job_status = "$base_url/jobdetails/updateassignjobstatus";
var verify_otp = "$base_url/auth/verifyotp";