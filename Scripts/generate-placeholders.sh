#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
RESOURCE_DIR="${PROJECT_ROOT}/SnowVillage.docc/Tutorials/Resources"

if [[ ! -d "${RESOURCE_DIR}" ]]; then
    echo "Resources directory not found: ${RESOURCE_DIR}" >&2
    exit 1
fi

PLACEHOLDER_CACHE="${TMPDIR:-/tmp}/snow-village-swift-module-cache"
mkdir -p "${PLACEHOLDER_CACHE}"

CLANG_MODULE_CACHE_PATH="${PLACEHOLDER_CACHE}" \
SWIFT_MODULE_CACHE_PATH="${PLACEHOLDER_CACHE}" \
xcrun swift -module-cache-path "${PLACEHOLDER_CACHE}" \
    "${SCRIPT_DIR}/PlaceholderRenderer.swift" "${RESOURCE_DIR}" <<'PLACEHOLDERS'
tutorial-cover.png|눈 내리는 겨울 마을|Tutorial Catalog 표지
chapter1-cover.png|프로젝트 구성 및 겨울 마을 만들기|Chapter 1 표지
chapter2-cover.png|겨울 분위기 연출하기|Chapter 2 표지
step01-open-rcp.png|Reality Composer Pro 3 열기|Welcome 화면
step02-new-project.png|새 프로젝트 만들기|새 프로젝트 생성 화면
step03-project-name.png|프로젝트 이름 설정하기|SnowVillage 이름 입력
step04-import-assets.png|3D 에셋 불러오기|Finder에서 Project Browser로 가져오기
step05-project-browser.png|에셋 확인하기|Project Browser의 7개 에셋
step06-floor.png|Floor 추가하기|Floor를 장면으로 드래그
step07-floor-position.png|Floor 원점 맞추기|Position X/Y/Z = 0
step08-igloo.png|Igloo 배치하기|Floor 위 중심 오브젝트
step09-tree.png|Tree 추가하기|첫 번째 Tree 배치
step10-tree-duplicate.png|Tree 복제하기|Command-D로 여러 개 만들기
step11-move.png|Move Gizmo 사용하기|복제한 Tree 이동
step12-rotate.png|Rotate Gizmo 사용하기|Tree 방향 변경
step13-layout.png|나머지 에셋 배치하기|Rock, Log, Signpost, Snowman
step14-complete-layout.png|기본 마을 완성하기|눈 효과를 넣기 전 장면
step15-directional-light.png|Directional Light 추가하기|WinterLight 생성
step16-light-rotation.png|빛 방향 조절하기|Rotation 설정
step17-light-intensity.png|밝기 조절하기|Intensity 설정
step18-shadow.png|그림자 확인하기|Floor와 Igloo의 그림자
step19-snowman.png|Snowman 애니메이션 열기|Sequence와 애니메이션 클립
step20-repeat.png|애니메이션 반복하기|Repeat Mode와 Repeats Forever
step21-animation.png|애니메이션 확인하기|Sequence Editor Play
step22-particle.png|Particle Emitter 추가하기|SnowEmitter Component
step23-snow-preset.png|Snow 프리셋 적용하기|Preset에서 Snow 선택
step24-particle-position.png|Emitter 위치 조절하기|마을 위 방출 영역
step25-birthrate.png|눈의 양 조절하기|Birth Rate 설정
step26-size.png|눈송이 크기 조절하기|Size 설정
step27-lifespan.png|눈의 수명 조절하기|Life Span 설정
step28-simulate.png|전체 장면 재생하기|Simulate와 Play
step29-final-result.png|겨울 마을 완성하기|조명, 애니메이션, 눈 파티클
PLACEHOLDERS

echo "Generated 32 placeholder images in ${RESOURCE_DIR}"
