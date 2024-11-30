import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post_model.dart';
import '../services/firestore_service.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  _UploadPostScreenState createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final _skillsController = TextEditingController();
  final _projectLinkController = TextEditingController();

  @override
  void dispose() {
    _projectNameController.dispose();
    _projectDescriptionController.dispose();
    _skillsController.dispose();
    _projectLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Project',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Project Name Input
                _buildInputField(
                  controller: _projectNameController,
                  label: 'Project Name',
                  hint: 'Enter your project name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Project name is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildInputField(
                  controller: _projectDescriptionController,
                  label: 'Project Description',
                  hint: 'Describe your project in detail',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Project description is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildInputField(
                  controller: _skillsController,
                  label: 'Skills Required',
                  hint: 'Enter skills separated by commas',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Skills are required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                _buildInputField(
                  controller: _projectLinkController,
                  label: 'Project Link',
                  hint: 'Optional: Add a link to your project',
                  isOptional: true,
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _submitPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    'Upload Project',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom input field builder
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
    bool isOptional = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: GoogleFonts.roboto(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: GoogleFonts.roboto(
          color: Colors.grey.shade400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: isOptional
          ? null
          : (validator ?? (value) => null),
    );
  }

  void _submitPost() async {
    if (_formKey.currentState?.validate() ?? false) {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final post = Post(
          id: '',
          userId: user.uid,
          projectName: _projectNameController.text,
          projectDescription: _projectDescriptionController.text,
          skillsRequired: _skillsController.text.split(',').map((skill) => skill.trim()).toList(),
          projectLink: _projectLinkController.text.isNotEmpty ? _projectLinkController.text : null,
          createdAt: Timestamp.now(),
          username: user.displayName ?? 'Anonymous',
        );

        try {
          await FirestoreService().addPost(post);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Project uploaded successfully!',
                style: GoogleFonts.roboto(),
              ),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to upload project. Please try again.',
                style: GoogleFonts.roboto(),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User is not logged in. Please log in to post.',
              style: GoogleFonts.roboto(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}