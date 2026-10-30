# hackathon-kit

4시간 안팎의 AI 협업 실무 과제(코딩 에이전트 + 가상 실무자)를 위한 개인 작업 양식입니다.

**이 레포에는 과제 코드나 앱 뼈대가 없습니다.** 작업 과정을 기록하는 문서 양식, 기록 잡무를 돕는 에이전트 스킬, 이를 복사하는 설치 스크립트만 있습니다.

## 들어 있는 것

| 경로 | 내용 |
|---|---|
| `AGENTS.template.md` | 코딩 에이전트용 작업 규칙 양식 (설치 시 `AGENTS.md`) |
| `templates/docs/` | INTERVIEW, REQUIREMENTS, PLAN, DECISIONS, VERIFY 양식 (HANDOFF는 `handoff` 스킬이 필요할 때 만듦) |
| `templates/gitignore` | 기본 `.gitignore` 항목 |
| `.agents/skills/` | 기록용 스킬 4개: `cross-review`, `verify-log`, `handoff`, `checkpoint` |
| `setup.sh` | 위 파일을 작업 폴더에 복사 |

## 사용법

```bash
git clone https://github.com/cattlyh55-sudo/hackathon-kit /tmp/kit
cd <과제 폴더>
bash /tmp/kit/setup.sh
```

- 이미 있는 파일은 **덮어쓰지 않습니다.** (과제에 `AGENTS.md`가 있으면 `docs/AGENTS.kit.md`로 따로 둡니다.)
- `.gitignore`가 있으면 빠진 항목만 덧붙입니다.

## 원칙

- **판단은 사람이, 기록 잡무만 도구로.** 인터뷰, 합의, 계획 승인, 우선순위 결정은 스킬로 자동화하지 않습니다.
- 스킬은 사용자가 명시적으로 부를 때만 쓰도록 설명을 적었습니다 (`$cross-review` 등).
- 설치 스크립트와 스킬은 **네트워크 호출, 외부 전송, 다른 AI 모델 호출을 하지 않습니다.** MCP 설정도 포함하지 않습니다.
- `AGENTS.template.md`에는 웹 검색 사용 규칙(과제 데이터를 검색어에 넣지 않기, 코드 통째 차용 금지, 출처 표시)과 화면 자동 조작 도구 금지가 들어 있습니다.
- 이 키트를 사용했다면 결과물 README에 출처를 밝힙니다.
