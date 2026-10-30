#!/usr/bin/env bash
# hackathon-kit 설치: 양식과 스킬을 작업 폴더에 복사한다.
# - 기존 파일은 덮어쓰지 않는다.
# - 네트워크 호출, 외부 전송을 하지 않는다.
# 사용법: bash /path/to/hackathon-kit/setup.sh [작업폴더, 기본값: 현재 폴더]
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$(cd "${1:-.}" && pwd)"

if [ "$KIT_DIR" = "$TARGET" ]; then
  echo "키트 폴더 자체에는 설치할 수 없습니다. 과제 폴더로 이동한 뒤 실행하세요." >&2
  exit 1
fi

created=()
skipped=()

copy_file() {  # copy_file <src> <dst>
  local src="$1" dst="$2"
  if [ -e "$dst" ]; then
    skipped+=("${dst#"$TARGET"/}")
  else
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    created+=("${dst#"$TARGET"/}")
  fi
}

# 1) 문서 양식
for f in "$KIT_DIR"/templates/docs/*.md; do
  copy_file "$f" "$TARGET/docs/$(basename "$f")"
done

# 2) AGENTS.md (과제에 이미 있으면 따로 둔다)
agents_note=""
if [ -e "$TARGET/AGENTS.md" ]; then
  copy_file "$KIT_DIR/AGENTS.template.md" "$TARGET/docs/AGENTS.kit.md"
  agents_note="과제에 AGENTS.md가 이미 있습니다. 내용을 먼저 읽고, 필요한 규칙만 docs/AGENTS.kit.md에서 옮기세요."
else
  copy_file "$KIT_DIR/AGENTS.template.md" "$TARGET/AGENTS.md"
fi

# 3) 스킬 (스킬 폴더 단위로, 이미 있으면 건너뜀)
for d in "$KIT_DIR"/.agents/skills/*/; do
  name="$(basename "$d")"
  dst="$TARGET/.agents/skills/$name"
  if [ -e "$dst" ]; then
    skipped+=(".agents/skills/$name/")
  else
    mkdir -p "$TARGET/.agents/skills"
    cp -R "$d" "$dst"
    created+=(".agents/skills/$name/")
  fi
done

# 4) .gitignore (없으면 만들고, 있으면 빠진 항목만 덧붙임)
gi="$TARGET/.gitignore"
if [ ! -e "$gi" ]; then
  cp "$KIT_DIR/templates/gitignore" "$gi"
  created+=(".gitignore")
else
  missing=()
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in ''|'#'*) continue ;; esac
    grep -qxF -- "$line" "$gi" || missing+=("$line")
  done < "$KIT_DIR/templates/gitignore"
  if [ "${#missing[@]}" -gt 0 ]; then
    last_char="$(tail -c1 "$gi")"
    { [ -n "$last_char" ] && echo; echo "# added by hackathon-kit"; printf '%s\n' "${missing[@]}"; } >> "$gi"
    created+=(".gitignore (+${#missing[@]}개 항목)")
  else
    skipped+=(".gitignore")
  fi
fi

# 결과
echo "== hackathon-kit 설치 완료: $TARGET"
if [ "${#created[@]}" -gt 0 ]; then
  echo "만든 것:"; printf '  + %s\n' "${created[@]}"
fi
if [ "${#skipped[@]}" -gt 0 ]; then
  echo "이미 있어서 건너뛴 것:"; printf '  = %s\n' "${skipped[@]}"
fi
[ -n "$agents_note" ] && echo "주의: $agents_note"
if ! git -C "$TARGET" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "주의: git 저장소가 아닙니다. 'git init' 후 첫 커밋을 하세요."
fi
echo
echo "다음 단계:"
echo "  1) Codex에서 '\$'를 입력해 cross-review, verify-log, handoff, checkpoint가 보이는지 확인"
echo "     (안 보이면: '.agents/skills/<이름>/SKILL.md를 읽고 그대로 수행해'라고 지시)"
