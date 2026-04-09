# Routing: Plan → Execute → Validate 순환

1. Planner → 실행 계획 수립 (태스크 목록 + 의존성 + 완료 기준)
2. Executor → 태스크 1부터 순서대로 구현
3. Validator → 완료된 태스크 검증
4. Pass → 다음 태스크로 진행 (Step 2로)
5. Revise → Planner가 계획 수정 후 재실행 (Step 1로)
6. 모든 태스크 Pass → Scribe가 최종 문서화
