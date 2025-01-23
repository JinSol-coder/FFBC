import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ErrorService {
  static final _logger = Logger('ErrorService');

  static void handleError(
      BuildContext context, String operation, dynamic error) {
    _logger.warning('$operation 실패: $error');

    String message = '오류가 발생했습니다';
    if (error.toString().contains('permission-denied')) {
      message = '권한이 없습니다';
    } else if (error.toString().contains('not-found')) {
      message = '데이터를 찾을 수 없습니다';
    } else if (error.toString().contains('network')) {
      message = '네트워크 연결을 확인해주세요';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: '확인',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
