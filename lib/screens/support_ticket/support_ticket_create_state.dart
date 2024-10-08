import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';

class SupportTicketCreateState {
  QuillController controller = QuillController.basic();
  TextEditingController subjectController = TextEditingController();

  var subject_category;

  //for image uploading
  ImagePicker picker = ImagePicker();
  File? image;
  var img_name;

  SupportTicketCreateState(
    this.controller,
    this.subjectController,
    this.subject_category,
    this.picker,
    this.image,
    this.img_name,
  );

  SupportTicketCreateState.initialState()
      : subject_category = '',
        img_name = '';
}
