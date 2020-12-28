#!/system/bin/sh

module_id="clash_premium"
module_path="/data/adb/modules"
clash_data_dir="/sdcard/Documents/clash"
clash_log="${clash_data_dir}/clash.log"
pid_file="${clash_data_dir}/clash.pid"

start_proxy() {
    ${module_path}/${module_id}/clash_service.sh start && \
    [ -f ${pid_file} ] && ${module_path}/${module_id}/clash_tproxy.sh enable
}

stop_proxy() {
    ${module_path}/${module_id}/clash_service.sh stop
    ${module_path}/${module_id}/clash_tproxy.sh disable
}

restart_proxy() {
    ${module_path}/${module_id}/clash_service.sh restart && \
    [ -f ${pid_file} ] && ${module_path}/${module_id}/clash_tproxy.sh restart
}

case "$1" in
  enable)
    start_proxy > ${clash_log}
    ;;
  disable)
    stop_proxy >> ${clash_log}
    ;;
  restart)
    restart_proxy > ${clash_log}
    ;;
  *)
    echo "$0:  usage:  $0 { enable | disable | restart }"
    ;;
esac