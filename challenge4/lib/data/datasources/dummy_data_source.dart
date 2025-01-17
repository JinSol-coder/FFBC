import 'dart:math' as math;

class DummyDataSource {
  static List<Map<String, dynamic>> getHomeContents() {
    return [
      {
        'category': 'AI 뉴스',
        'items': [
          {
            'id': 'ai1',
            'title': 'ChatGPT-5 출시 임박, AI 시장 판도 변화 예고',
            'imageUrl': 'https://picsum.photos/800/400?random=1',
            'description': 'OpenAI가 GPT-5 출시를 앞두고 있어 AI 시장에 큰 변화가 예상됩니다.',
          },
          {
            'id': 'ai2',
            'title': '구글, 새로운 AI 모델 공개',
            'imageUrl': 'https://picsum.photos/800/400?random=2',
            'description': '구글이 Gemini Advanced를 발표하며 AI 경쟁이 가속화되고 있습니다.',
          },
          {
            'id': 'ai3',
            'title': '국내 AI 스타트업 투자 급증',
            'imageUrl': 'https://picsum.photos/800/400?random=3',
            'description': '국내 AI 스타트업들이 대규모 투자를 유치하며 성장세를 보이고 있습니다.',
          },
        ],
      },
      {
        'category': '주식',
        'items': [
          {
            'id': 'stock1',
            'title': '삼성전자',
            'imageUrl': 'https://picsum.photos/800/400?random=4',
            'description': '78,000원 (+2.3%)',
          },
          {
            'id': 'stock2',
            'title': 'SK하이닉스',
            'imageUrl': 'https://picsum.photos/800/400?random=5',
            'description': '156,000원 (+1.8%)',
          },
          {
            'id': 'stock3',
            'title': 'NVIDIA',
            'imageUrl': 'https://picsum.photos/800/400?random=6',
            'description': '\$890.25 (+4.2%)',
          },
        ],
      },
      {
        'category': '비트코인',
        'items': [
          {
            'id': 'crypto1',
            'title': 'Bitcoin (BTC)',
            'imageUrl': 'https://picsum.photos/800/400?random=7',
            'description': '\$45,123.45 (+2.5%)',
          },
          {
            'id': 'crypto2',
            'title': 'Ethereum (ETH)',
            'imageUrl': 'https://picsum.photos/800/400?random=8',
            'description': '\$2,890.12 (+1.8%)',
          },
        ],
      },
      {
        'category': '환율 통계',
        'items': [
          {
            'id': 'exchange1',
            'title': 'USD/KRW',
            'imageUrl': 'https://picsum.photos/800/400?random=13',
            'description': '1,320.50원 (-0.3%)',
          },
          {
            'id': 'exchange2',
            'title': 'JPY/KRW',
            'imageUrl': 'https://picsum.photos/800/400?random=14',
            'description': '916.85원 (-0.5%)',
          },
          {
            'id': 'exchange3',
            'title': 'EUR/KRW',
            'imageUrl': 'https://picsum.photos/800/400?random=15',
            'description': '1,450.30원 (+0.2%)',
          },
          {
            'id': 'exchange4',
            'title': 'CNY/KRW',
            'imageUrl': 'https://picsum.photos/800/400?random=16',
            'description': '189.50원 (-0.1%)',
          },
        ],
      },
    ];
  }

  static List<Map<String, dynamic>> getNewsContents() {
    return [
      {
        'category': '정치',
        'items': [
          {
            'id': 'politics1',
            'title': '한미 정상회담 개최, 경제 협력 강화 논의',
            'imageUrl': 'https://picsum.photos/800/400?random=9',
            'description': '양국 간 경제 협력 강화 방안과 글로벌 공급망 안정화 논의...',
          },
          {
            'id': 'politics2',
            'title': '새로운 경제 정책 발표 예정',
            'imageUrl': 'https://picsum.photos/800/400?random=10',
            'description': '정부, 물가안정과 경제성장을 위한 새로운 정책 패키지 준비...',
          },
        ],
      },
      {
        'category': '경제',
        'items': [
          {
            'id': 'economy1',
            'title': '한국은행, 기준금리 동결 결정',
            'imageUrl': 'https://picsum.photos/800/400?random=11',
            'description': '현재 경제 상황을 고려해 기준금리 유지 결정...',
          },
          {
            'id': 'economy2',
            'title': '수출 실적 개선세, 무역수지 흑자 전환',
            'imageUrl': 'https://picsum.photos/800/400?random=12',
            'description': '반도체 수출 회복으로 3개월 연속 무역수지 흑자 기록...',
          },
        ],
      },
      {
        'category': '이슈',
        'items': [
          {
            'id': 'issue1',
            'title': '글로벌 테크 기업들의 AI 개발 경쟁 심화',
            'imageUrl': 'https://picsum.photos/800/400?random=21',
            'description': '주요 테크 기업들의 AI 기술 개발 경쟁이 가속화되고 있어...',
          },
          {
            'id': 'issue2',
            'title': '가상화폐 시장 변동성 확대',
            'imageUrl': 'https://picsum.photos/800/400?random=22',
            'description': '주요 가상화폐의 가격 변동성이 확대되며 투자자들의 관심 집중...',
          },
        ],
      },
      {
        'category': '연예',
        'items': [
          {
            'id': 'entertainment1',
            'title': '엔터테인먼트 기업 실적 호조',
            'imageUrl': 'https://picsum.photos/800/400?random=23',
            'description': 'K-콘텐츠의 글로벌 인기에 힘입어 주요 엔터테인먼트 기업들의 실적 개선...',
          },
        ],
      },
      {
        'category': '스포츠',
        'items': [
          {
            'id': 'sports1',
            'title': '스포츠 구단 가치 상승세',
            'imageUrl': 'https://picsum.photos/800/400?random=24',
            'description': '프로스포츠 구단들의 기업 가치가 지속적으로 상승하며...',
          },
        ],
      },
    ];
  }

  static List<Map<String, dynamic>> getRecommendations() {
    return [
      {
        'category': '국내 주목주',
        'items': [
          {
            'id': 'domestic1',
            'title': '삼성전자',
            'imageUrl': 'https://picsum.photos/800/400?random=17',
            'description': '신규 반도체 라인 가동 예정',
            'trend': '상승',
            'percentage': '+3.2%',
            'recommendation': '매수 고려',
          },
          {
            'id': 'domestic2',
            'title': 'SK하이닉스',
            'imageUrl': 'https://picsum.photos/800/400?random=18',
            'description': 'AI 반도체 수요 증가',
            'trend': '상승',
            'percentage': '+2.8%',
            'recommendation': '매수 고려',
          },
          {
            'id': 'domestic3',
            'title': '현대차',
            'imageUrl': 'https://picsum.photos/800/400?random=19',
            'description': '전기차 신모델 출시 예정',
            'trend': '상승',
            'percentage': '+1.5%',
            'recommendation': '매수 고려',
          },
        ],
      },
      {
        'category': '해외 주목주',
        'items': [
          {
            'id': 'global1',
            'title': '테슬라',
            'imageUrl': 'https://picsum.photos/800/400?random=20',
            'description': '신규 모델 출시 예정',
            'trend': '상승',
            'percentage': '+5.2%',
            'recommendation': '매수 고려',
          },
          {
            'id': 'global2',
            'title': '애플',
            'imageUrl': 'https://picsum.photos/800/400?random=21',
            'description': 'AI 관련 신규 사업 발표 예정',
            'trend': '상승',
            'percentage': '+2.8%',
            'recommendation': '매수 고려',
          },
          {
            'id': 'global3',
            'title': 'NVIDIA',
            'imageUrl': 'https://picsum.photos/800/400?random=22',
            'description': 'AI 칩 수요 급증',
            'trend': '상승',
            'percentage': '+4.5%',
            'recommendation': '매수 고려',
          },
        ],
      },
    ];
  }

  static List<Map<String, dynamic>> getMoreAINews() {
    return List.generate(20, (index) => {
      'id': 'ai${index + 4}',
      'title': 'AI 뉴스 제목 ${index + 4}',
      'imageUrl': 'https://picsum.photos/800/400?random=${index + 20}',
      'description': 'AI 뉴스 내용 ${index + 4}',
    });
  }

  static List<Map<String, dynamic>> getMoreExchangeRates() {
    final countries = [
      '미국', '일본', '유럽', '중국', '영국', 
      '호주', '캐나다', '스위스', '홍콩', '싱가포르'
    ];
    
    return List.generate(10, (index) => {
      'id': 'exchange${index + 5}',
      'title': '${countries[index]}/KRW',
      'imageUrl': 'https://picsum.photos/800/400?random=${index + 30}',
      'description': '${(1000 + math.Random().nextInt(500)).toDouble()} (-${(math.Random().nextDouble() * 2).toStringAsFixed(2)}%)',
    });
  }
} 