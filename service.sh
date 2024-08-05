#!/system/bin/sh
#/magisk/modname/をハードコーディングしないでください...;代わりに $MODDIR ＃これにより、Magiskが将来マウントポイントを変更した場合でも、スクリプトに互換性があります。

# Waiting for boot completed
while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 5; done

# Path
MODDIR=${0%/*}

su -lp 2000 -c "cmd notification post -S bigtext -t 'Corin X MTKVest' tag 'Applying Tweaks, please wait...'" >/dev/null 2>&1

# Scheduler I/O
echo "deadline" > /sys/block/sda/queue/scheduler
echo "deadline" > /sys/block/sdb/queue/scheduler
echo "deadline" > /sys/block/sdc/queue/scheduler

#printk
echo "0 0 0 0" > /proc/sys/kernel/printk
echo "1" > /sys/module/printk/parameters/console_suspend
echo "1" > /sys/module/printk/parameters/ignore_loglevel
echo "0" > /sys/module/printk/parameters/time
echo "off" > /proc/sys/kernel/printk_devkmsg

# Networking tweaks
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
echo "1" > /proc/sys/net/ipv4/tcp_low_latency
echo "1" > /proc/sys/net/ipv4/tcp_ecn
echo "1" > /proc/sys/net/ipv4/tcp_sack
echo "1" > /proc/sys/net/ipv4/tcp_timestamps

# Charging
echo "1" > /sys/devices/platform/charger/fast_chg_indicator

fstrim -v /cache
fstrim -v /metadata
fstrim -v /data

echo "0" > /sys/module/mtk_core_ctl/parameters/policy_enable

# FPSGo & GED Param

# FPSGo & PNPMGR Enable 50-70% Work
echo "1" > /sys/pnpmgr/fpsgo_boost/boost_mode
echo "1" > /sys/pnpmgr/install
echo "0" > /sys/pnpmgr/mwn
echo "2" > /sys/module/mtk_fpsgo/parameters/bhr_opp
echo "1" > /sys/module/mtk_fpsgo/parameters/bhr_opp_l
echo "1" > /sys/module/mtk_fpsgo/parameters/boost_affinity
echo "1" > /sys/module/mtk_fpsgo/parameters/xgf_uboost
echo "-1" > /sys/module/mtk_fpsgo/parameters/uboost_enhance_f
echo "1" > /sys/module/mtk_fpsgo/parameters/gcc_fps_margin
echo "1" > /sys/module/mtk_fpsgo/parameters/rescue_enhance_f
echo "1" > /sys/module/mtk_fpsgo/parameters/qr_mod_frame
echo "1" > /sys/module/mtk_fpsgo/parameters/fstb_separate_runtime_enable
echo "1" > /sys/module/mtk_fpsgo/parameters/fstb_consider_deq
echo "0" > /sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_quantile
echo "1" > /sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_error_threshold
echo "1" > /sys/pnpmgr/fpsgo_boost/fstb/margin_mode
echo "2" > /sys/pnpmgr/fpsgo_boost/fbt/bhr_opp
echo "-1" > /sys/pnpmgr/fpsgo_boost/fbt/adjust_loading
echo "-1" > /sys/pnpmgr/fpsgo_boost/fbt/dyn_tgt_time_en
echo "2" > /sys/pnpmgr/fpsgo_boost/fbt/floor_opp
echo "-1" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_enhance_f
echo "-1" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_c
echo "-1" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_f
echo "-1" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_percent
echo "1" > /sys/pnpmgr/fpsgo_boost/fbt/ultra_rescue
echo "0" > /sys/kernel/fpsgo/xgf/xgf_trace_enable
echo "1" > /sys/kernel/fpsgo/fstb/tfps_to_powerhal_enable
echo "1" > /sys/kernel/fpsgo/fstb/set_cam_active
echo "1" > /sys/kernel/fpsgo/fbt/boost_ta

# GED Parameter 80% Work
echo "0" > /sys/module/ged/parameters/ged_smart_boost
echo "-1" > /sys/module/ged/parameters/gpu_cust_upbound_freq
echo "1" > /sys/module/ged/parameters/enable_gpu_boost
echo "1" > /sys/module/ged/parameters/ged_boost_enable
echo "1" > /sys/module/ged/parameters/boost_gpu_enable
echo "1" > /sys/module/ged/parameters/ged_monitor_3D_fence_systrace
echo "-1" > /sys/module/ged/parameters/g_fb_dvfs_threshold
echo "0" > /sys/module/ged/parameters/g_gpu_timer_based_emu
echo "-1" > /sys/module/ged/parameters/gpu_cust_boost_freq
echo "-1" > /sys/kernel/ged/hal/gpu_boost_level
echo "0" > /sys/module/ged/parameters/is_GED_KPI_enabled
echo "-1" > /sys/kernel/ged/hal/custom_boost_gpu_freq
echo "-1" > /sys/kernel/ged/hal/custom_upbound_gpu_freq
echo "0" > /sys/kernel/ged/hal/dvfs_loading_mode
echo "0" > /sys/kernel/ged/hal/dvfs_workload_mode
echo "-1" > /sys/kernel/ged/hal/dvfs_margin_value

sleep 10
su -lp 2000 -c "cmd notification post -S bigtext -t 'Corin X MTKVest' tag 'Tweaks Applied Successfuly'" >/dev/null 2>&1

am start -a android.intent.action.MAIN -e toasttext "Tweak Applied" -n bellavita.toast/.MainActivity

# このスクリプトはlate_startサービスモードで実行されます ＃メインのMagiskスレッドの詳細
