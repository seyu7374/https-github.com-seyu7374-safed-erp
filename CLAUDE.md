# SAFED ERP 프로젝트 규칙

회사 업무를 공유할 수 있는 업무자동화 ERP 도구입니다.

## 기술 스택 (고정)
- **프론트엔드**: Next.js 16 (App Router) + TypeScript + Tailwind CSS
- **백엔드**: Supabase (데이터베이스)
- **배포**: Vercel
- **AI**: Gemini API (향후)
- **폰트**: Inter + Manrope (design.md 참고)

## 프로젝트 구조
- `/src/app` - 페이지 라우트
- `/src/components` - 재사용 컴포넌트
- `/src/lib` - 유틸리티 함수
- `/public` - 정적 자산

## 핵심 기능 (MVP)
1. **지출/보고서 관리** (지출결의서, 주간업무보고, 출장보고서)
2. **출장/외근 일정 관리** (팀 현황판)
3. **프로젝트 관리** (향후)

## 디자인 원칙
- design.md 항상 참고 (색상, 폰트, 레이아웃, 컴포넌트)
- 현대적 미니멀리즘 유지
- 폰트: Manrope (헤딩), Inter (본문)
- 색상: 흑/백/회색만 사용
- Pretendard 금지 (Inter + Manrope만)

## 파일 규칙
- `draft.md` = 요구사항 정의 (항상 확인)
- `design.md` = 디자인 시스템 (항상 참고)
- `service-prd.md` = Phase별 기능 정의 (필요시)
- `.env.local` = 사용자가 직접 관리

## Phase 진행 규칙
- Phase 1 완성 후 Phase 2 추가
- Phase가 작동 안 할 땐 다음 Phase 추가하지 말 것

## 응답 톤
- 모든 설명은 한국어로
- 큰 변경 전 진행 계획 간단히 보여주기
- 작업 후 1~3줄 요약

## 데이터 안전
- Supabase 스키마 변경 시 명시적 확인
- 데이터 삭제는 사용자 요청 시에만
