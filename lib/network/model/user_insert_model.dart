import 'dart:io';

class UserInsert {
  var technician_id = "";
  var service_id = "";
  var consumer_id = "";
  File image;
  var message = "";

  UserInsert({this.message, this.service_id, this.image, this.consumer_id, this.technician_id});
}