import 'package:flutter/material.dart';
import 'package:medical_app/config/theme/theme_style.dart';
import 'package:medical_app/widgets/app_text_field_widget.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(backgroundColor: AppColors.white, body: _buildBody),
    );
  }

  Widget get _buildBody {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          _buildSliverAppBar(context, isScrolled: innerBoxIsScrolled),
          const SliverToBoxAdapter(),
        ];
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Your page content
            _buildTextFormFields,
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(
    BuildContext context, {
    required bool isScrolled,
  }) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: false,
      // expandedHeight: 70,
      backgroundColor: isScrolled
          ? AppTheme.secondarySwatch
          : AppTheme.secondarySwatch,
      elevation: isScrolled ? 4 : 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Sign In', style: AppTextStyle.bold24(color: Colors.white)),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget get _buildTextFormFields {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextFieldWidget(
              hintText: "Email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val.isEmpty) return "Email required";
                if (!val.contains("@")) return "Enter a valid email";
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextFieldWidget(
              hintText: "Password",
              controller: passwordController,
              isPassword: true,
              validator: (val) {
                if (val == null || val.isEmpty) return "Password required";
                if (val.length < 6) return "At least 6 characters";
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // 🔥 Sign In logic here
                }
              },
              child: const Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}

// ======
