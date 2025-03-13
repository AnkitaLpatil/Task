import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserAddForm extends StatefulWidget {
  const UserAddForm({super.key});

  @override
  _UserAddFormState createState() => _UserAddFormState();
}

class _UserAddFormState extends State<UserAddForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController billingNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController landlineController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController assigneeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Title dropdown options
  String selectedTitle = 'Mr';
  final List<String> titleOptions = ['Miss', 'Mr', 'Mrs'];

  // Function to pick a date
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  // Function to submit data to Firestore
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firestore.collection("users").add({
          "title": selectedTitle,
          "name": nameController.text,
          "billingName": billingNameController.text,
          "dob": dobController.text,
          "email": emailController.text,
          "landline": landlineController.text,
          "mobile": mobileController.text,
          "assignee": assigneeController.text,
          "website": websiteController.text,
          "timestamp": FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User Added Successfully!")),
        );

        // Clear fields after successful submission
        setState(() {
          nameController.clear();
          billingNameController.clear();
          dobController.clear();
          emailController.clear();
          landlineController.clear();
          mobileController.clear();
          assigneeController.clear();
          websiteController.clear();
          selectedTitle = 'Mr';
        });
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to add user")),
        );
      }
    }
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Form"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: selectedTitle,
                              decoration: InputDecoration(
                                labelText: "",
                                prefixIcon: const Icon(Icons.title,
                                    color: Colors.blueAccent),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              items: titleOptions.map((String title) {
                                return DropdownMenuItem(
                                    value: title, child: Text(title));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTitle = value!;
                                });
                              },
                              validator: (value) =>
                                  value == null ? "Select a title" : null,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Name",
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.blueAccent),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? "Enter a name" : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: dobController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Date of Birth",
                          prefixIcon: const Icon(Icons.calendar_today,
                              color: Colors.blueAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: _pickDate,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Date of Birth cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    buildTextField(
                        "Billing Name", billingNameController, Icons.business),
                    buildTextField("Email", emailController, Icons.email),
                    buildTextField(
                        "Landline Number", landlineController, Icons.phone),
                    buildTextField(
                        "Mobile Number", mobileController, Icons.smartphone),
                    buildTextField("Assignee", assigneeController, Icons.person),
                    buildTextField("Website", websiteController, Icons.web),
                    const SizedBox(height: 20, width: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Submit",
                            style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label cannot be empty";
          }
          return null;
        },
      ),
    );
  }
}
