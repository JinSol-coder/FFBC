import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/my_viewmodel.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY'),
      ),
      body: Consumer<MyViewModel>(
        builder: (context, viewModel, child) {
          return ListView(
            children: [
              // 프로필 섹션
              _buildProfileSection(context, viewModel),
              const Divider(),

              // 알림 설정 섹션
              _buildNotificationSection(context, viewModel),
              const Divider(),

              // 앱 설정 섹션
              _buildAppSettingsSection(context, viewModel),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, MyViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '프로필',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.grey[600],
              ),
            ),
            title: Text(viewModel.profile.name),
            subtitle: const Text('프로필 편집'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showEditProfileDialog(context, viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection(BuildContext context, MyViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '알림 설정',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('푸시 알림'),
            subtitle: const Text('앱 푸시 알림 받기'),
            value: viewModel.profile.pushNotification,
            onChanged: viewModel.togglePushNotification,
          ),
          SwitchListTile(
            title: const Text('이메일 알림'),
            subtitle: const Text('이메일로 알림 받기'),
            value: viewModel.profile.emailNotification,
            onChanged: viewModel.toggleEmailNotification,
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettingsSection(BuildContext context, MyViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '앱 설정',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('테마'),
            subtitle: Text(viewModel.profile.theme),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeDialog(context, viewModel),
          ),
          ListTile(
            title: const Text('언어'),
            subtitle: Text(viewModel.profile.language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageDialog(context, viewModel),
          ),
          ListTile(
            title: const Text('앱 정보'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 앱 정보 화면으로 이동
            },
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, MyViewModel viewModel) {
    final controller = TextEditingController(text: viewModel.profile.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('프로필 편집'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: '이름',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              viewModel.updateName(controller.text);
              Navigator.pop(context);
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context, MyViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('테마 설정'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              viewModel.updateTheme('system');
              Navigator.pop(context);
            },
            child: const Text('시스템'),
          ),
          SimpleDialogOption(
            onPressed: () {
              viewModel.updateTheme('light');
              Navigator.pop(context);
            },
            child: const Text('라이트'),
          ),
          SimpleDialogOption(
            onPressed: () {
              viewModel.updateTheme('dark');
              Navigator.pop(context);
            },
            child: const Text('다크'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, MyViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('언어 설정'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              viewModel.updateLanguage('ko');
              Navigator.pop(context);
            },
            child: const Text('한국어'),
          ),
          SimpleDialogOption(
            onPressed: () {
              viewModel.updateLanguage('en');
              Navigator.pop(context);
            },
            child: const Text('English'),
          ),
        ],
      ),
    );
  }
} 