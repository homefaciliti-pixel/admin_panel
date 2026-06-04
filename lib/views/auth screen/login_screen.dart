import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth/login_viewmodel.dart';
import '../mainScreen/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "ONLY LOGIN SCREEN",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   final emailController = TextEditingController();
  //   final passwordController = TextEditingController();
  //   final formKey = GlobalKey<FormState>();
  //
  //   return Consumer<LoginViewModel>(
  //     builder: (context, vm, child) {
  //       return Scaffold(
  //         body: Container(
  //           width: double.infinity,
  //           height: double.infinity,
  //           decoration: const BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [Color(0xffF8FAFC), Color(0xffE2E8F0)],
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //             ),
  //           ),
  //           child: Center(
  //             child: SingleChildScrollView(
  //               padding: const EdgeInsets.all(24),
  //               child: ConstrainedBox(
  //                 constraints: const BoxConstraints(maxWidth: 420),
  //                 child: Container(
  //                   padding: const EdgeInsets.all(28),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(24),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.black.withOpacity(0.08),
  //                         blurRadius: 24,
  //                         offset: const Offset(0, 10),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Form(
  //                     key: formKey,
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         /// LOGO
  //                         Container(
  //                           height: 90,
  //                           width: 90,
  //                           padding: const EdgeInsets.all(14),
  //                           decoration: BoxDecoration(
  //                             color: const Color(0xffF8FAFC),
  //                             borderRadius: BorderRadius.circular(22),
  //                             border: Border.all(color: Colors.grey.shade200),
  //                           ),
  //                           child: Image.asset(
  //                             "assets/images/logo.png",
  //                             fit: BoxFit.contain,
  //                             errorBuilder: (context, error, stackTrace) {
  //                               return const Icon(
  //                                 Icons.apartment_rounded,
  //                                 size: 44,
  //                                 color: Color(0xff111827),
  //                               );
  //                             },
  //                           ),
  //                         ),
  //
  //                         const SizedBox(height: 18),
  //
  //                         const Text(
  //                           "Admin Login",
  //                           style: TextStyle(
  //                             fontSize: 26,
  //                             fontWeight: FontWeight.bold,
  //                             color: Color(0xff111827),
  //                           ),
  //                         ),
  //
  //                         const SizedBox(height: 8),
  //
  //                         Text(
  //                           "Sign in to manage your dashboard",
  //                           style: TextStyle(
  //                             fontSize: 14,
  //                             color: Colors.grey.shade600,
  //                           ),
  //                         ),
  //
  //                         const SizedBox(height: 28),
  //
  //                         /// EMAIL
  //                         TextFormField(
  //                           controller: emailController,
  //                           keyboardType: TextInputType.emailAddress,
  //                           decoration: InputDecoration(
  //                             labelText: "Email ID",
  //                             hintText: "Enter email id",
  //                             prefixIcon: const Icon(Icons.email_outlined),
  //                             filled: true,
  //                             fillColor: Colors.grey.shade50,
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(14),
  //                               borderSide: BorderSide(
  //                                 color: Colors.grey.shade300,
  //                               ),
  //                             ),
  //                             enabledBorder: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(14),
  //                               borderSide: BorderSide(
  //                                 color: Colors.grey.shade300,
  //                               ),
  //                             ),
  //                             focusedBorder: const OutlineInputBorder(
  //                               borderRadius: BorderRadius.all(
  //                                 Radius.circular(14),
  //                               ),
  //                               borderSide: BorderSide(
  //                                 color: Color(0xff111827),
  //                                 width: 1.2,
  //                               ),
  //                             ),
  //                           ),
  //                           validator: (value) {
  //                             if (value == null || value.trim().isEmpty) {
  //                               return "Please enter email id";
  //                             }
  //                             if (!value.contains("@")) {
  //                               return "Please enter valid email";
  //                             }
  //                             return null;
  //                           },
  //                         ),
  //
  //                         const SizedBox(height: 16),
  //
  //                         /// PASSWORD
  //                         TextFormField(
  //                           controller: passwordController,
  //                           obscureText: vm.obscurePassword,
  //                           decoration: InputDecoration(
  //                             labelText: "Password",
  //                             hintText: "Enter password",
  //                             prefixIcon: const Icon(Icons.lock_outline),
  //                             suffixIcon: IconButton(
  //                               onPressed: () {
  //                                 vm.togglePasswordVisibility();
  //                               },
  //                               icon: Icon(
  //                                 vm.obscurePassword
  //                                     ? Icons.visibility_off_outlined
  //                                     : Icons.visibility_outlined,
  //                               ),
  //                             ),
  //                             filled: true,
  //                             fillColor: Colors.grey.shade50,
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(14),
  //                               borderSide: BorderSide(
  //                                 color: Colors.grey.shade300,
  //                               ),
  //                             ),
  //                             enabledBorder: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(14),
  //                               borderSide: BorderSide(
  //                                 color: Colors.grey.shade300,
  //                               ),
  //                             ),
  //                             focusedBorder: const OutlineInputBorder(
  //                               borderRadius: BorderRadius.all(
  //                                 Radius.circular(14),
  //                               ),
  //                               borderSide: BorderSide(
  //                                 color: Color(0xff111827),
  //                                 width: 1.2,
  //                               ),
  //                             ),
  //                           ),
  //                           validator: (value) {
  //                             if (value == null || value.trim().isEmpty) {
  //                               return "Please enter password";
  //                             }
  //                             if (value.length < 6) {
  //                               return "Password must be at least 6 characters";
  //                             }
  //                             return null;
  //                           },
  //                         ),
  //
  //                         if (vm.errorMessage != null) ...[
  //                           const SizedBox(height: 14),
  //                           Align(
  //                             alignment: Alignment.centerLeft,
  //                             child: Text(
  //                               vm.errorMessage!,
  //                               style: const TextStyle(
  //                                 color: Colors.red,
  //                                 fontSize: 13,
  //                                 fontWeight: FontWeight.w600,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //
  //                         const SizedBox(height: 24),
  //
  //                         /// LOGIN BUTTON
  //                         SizedBox(
  //                           width: double.infinity,
  //                           height: 52,
  //                           child: ElevatedButton(
  //                             onPressed: vm.isLoading
  //                                 ? null
  //                                 : () async {
  //                                     if (!formKey.currentState!.validate())
  //                                       return;
  //
  //                                     final success = await vm.login(
  //                                       email: emailController.text.trim(),
  //                                       password: passwordController.text
  //                                           .trim(),
  //                                     );
  //
  //                                     if (success && context.mounted) {
  //                                       ScaffoldMessenger.of(
  //                                         context,
  //                                       ).showSnackBar(
  //                                         const SnackBar(
  //                                           content: Text("Login success"),
  //                                         ),
  //                                       );
  //                                       Navigator.pushReplacement(
  //                                         context,
  //
  //                                         MaterialPageRoute(
  //                                           builder: (_) => const MainScreen(),
  //                                         ),
  //                                       );
  //                                     }
  //                                   },
  //                             style: ElevatedButton.styleFrom(
  //                               backgroundColor: const Color(0xff111827),
  //                               foregroundColor: Colors.white,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(14),
  //                               ),
  //                               elevation: 0,
  //                             ),
  //                             child: vm.isLoading
  //                                 ? const SizedBox(
  //                                     height: 20,
  //                                     width: 20,
  //                                     child: CircularProgressIndicator(
  //                                       strokeWidth: 2.2,
  //                                       color: Colors.white,
  //                                     ),
  //                                   )
  //                                 : const Text(
  //                                     "Login",
  //                                     style: TextStyle(
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.w700,
  //                                     ),
  //                                   ),
  //                           ),
  //                         ),
  //
  //                         const SizedBox(height: 14),
  //
  //                         Text(
  //                           "Only authorized admin can access",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             color: Colors.grey.shade500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  }

