#!/system/bin/sh
# / magisk/modname/をハードコーディングしないでください...;代わりに $MODDIR ＃これにより、Magiskが将来マウントポイントを変更した場合でも、スクリプトに互換性があります。
MODDIR=${0%/*}

resetprop -n tombstoned.max_tombstone_count 0

# low memory killer
resetprop -n ro.lmk.debug false
resetprop -n ro.lmk.log_stats false

