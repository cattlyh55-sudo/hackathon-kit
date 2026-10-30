---
name: handoff
description: 세션을 교체하기 전에 현재 상태를 docs/HANDOFF.md에 짧게 정리한다. 사용자가 인수인계나 세션 교체를 명시적으로 요청할 때만 사용한다.
---

# 인수인계

## 규칙
- 코드는 수정하지 않는다. docs/HANDOFF.md만 쓴다.
- 12줄 이내로 쓴다. 대화 내용을 옮기지 말고 저장소 상태를 근거로 쓴다.

## 절차
1. `git log --oneline -10`, `git status --short`, docs/PLAN.md, docs/VERIFY.md를 확인한다.
2. docs/HANDOFF.md를 다음 항목으로 갱신한다. 파일이 없으면 새로 만든다.
   - 현재 단계 (PLAN의 몇 단계인지)
   - 동작하는 것
   - 마지막 커밋 (해시와 메시지), 커밋되지 않은 변경 여부
   - 다음 할 일 (PLAN의 다음 단계와 완료 기준)
   - 미해결 이슈
   - 실행 / 테스트 명령
3. 사용자에게 "새 세션 첫 지시" 문장을 함께 제안한다:
   `AGENTS.md, docs/HANDOFF.md, docs/PLAN.md를 읽고 현재 상태를 3줄로 요약해. 코드는 아직 건드리지 마.`
