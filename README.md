# log_delete

### 목표
오래된 로그 파일 삭제 자동화
### 실행방법
sh ./suggest_log_delete.sh -l 삭제대상로그path -h 삭제기준일 (-d/-l)
```
sh /home/groonga_suggest/suggest_log_delete.sh -l /home/suggestlogs -h 90 -d > /dev/null 2>&1
```
### 실행모드
-d : 삭제모드
-l : dry run(삭제 대상 리스트 출력 모드)
