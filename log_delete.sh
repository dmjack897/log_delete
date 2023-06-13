#!/bin/bash

LOG="/home/groonga_suggest/suggest_log_delete/logs"
LOGFILE="${LOG}/`basename $0`_`date "+%Y%m%d%H%M"`.log"
Necessary_OPT=false
#옵션설정
Action_Select() {
    while getopts ":l:rdh:" opts; do
        case ${opts} in
            "l")
                Necessary_OPT=true
                DELETEDIR=$OPTARG
            ;;
            "h")
                Necessary_OPT=true
                day=$OPTARG
            ;;
            "r")
                Necessary_OPT=true
                mode="dry_run_mode"
            ;;
            "d")
                Necessary_OPT=true
                mode="delete_mode"
            ;;
            *)
                Necessary_OPT=false
            ;;
        esac
    done
}
{
#디렉토리지정 및 실행모드 설정
Action_Select $@
if [ "${Necessary_OPT}" != true ]; then
    echo "옵션설정방법
-l) 로그파일path
-h) 기간
-r) Dry run 모드
-d) Delete 모드"
       exit 1
fi
#디렉토리가 없는 경우
if [ ! -d $DELETEDIR ];then
    echo "디렉토리path 확인해주세요。"
    exit 1
fi
echo "START"
if [ "$mode" = "dry_run_mode" ]; then
    find $DELETEDIR -name "*-0*" -mtime +"$day" -exec ls -l {} \;
elif [ "$mode" = "delete_mode" ]; then
    find $DELETEDIR -name "*-0*" -mtime +"$day" -exec ls -l {} \;
    find $DELETEDIR -name "*-0*" -mtime +"$day" -exec rm {} \;
fi
echo "END"
#로그파일삭제
} 2>&1 |
while read line;
do
        echo "${line}" | tee -a ${LOGFILE}
done
        find $LOG -name "*.log" -mtime +7 -exec rm {} \;
