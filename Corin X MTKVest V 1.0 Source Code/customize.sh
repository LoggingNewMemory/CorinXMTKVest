#!/system/bin/sh

ui_print "====================================="
ui_print "         [ Corin X MTKVest ]         "
ui_print "====================================="
sleep 0.5
ui_print "         By: Kanagawa Yamada         "
ui_print "     Heavy Thanks to MTKVest Team    "
ui_print "-------------------------------------"
ui_print "       DO NOT COMBINE WITH ANY       "
ui_print "          PERFORMANCE MODULE         "
sleep 0.5
ui_print "-----------[ DEVICE INFO ]-----------"
sleep 0.5
ui_print "DEVICE : $(getprop ro.build.product) "
ui_print "MODEL : $(getprop ro.product.model) "
ui_print "MANUFACTURE : $(getprop ro.product.system.manufacturer) "
ui_print "PROC : $(getprop ro.product.board) "
ui_print "CPU : $(getprop ro.hardware) "
ui_print "ANDROID VER : $(getprop ro.build.version.release) "
ui_print "KERNEL : $(uname -r) "
ui_print "RAM : $(free | grep Mem |  awk '{print $2}') "
ui_print ""

ui_print "-----------[ MODULE INFO ]-----------"
sleep 0.5
ui_print "Name : Corin X MTKVest"
ui_print "Version : 1.0 "
ui_print "Support Device : Helio G99 series"
ui_print "Unofficial Support: MT 6833"
ui_print "Support Root : Magisk / KernelSU / APatch"
ui_print "Heavy Thanks to : MTKVest Team"
ui_print ""
sleep 1

ui_print "====================================="
ui_print "        Install MTK Vest App         "
ui_print "====================================="
pm install $MODPATH/system/priv-app/vest/vest.apk
pm install $MODPATH/Toast.apk
ui_print " "
ui_print "====================================="
ui_print "       MTK Vest App Installed        "
ui_print "====================================="

ui_print "====================================="
ui_print "           Applying SkiaVK           "
ui_print "====================================="

sed -i '1,$d' $MODPATH/system.prop
echo "debug.hwui.renderer=skiavk" >> $MODPATH/system.prop
ui_print ""
sleep 0.2

ui_print "====================================="
ui_print "            SkiaVK Applied           "
ui_print "====================================="
ui_print ""
ui_print "====================================="
ui_print "       Install Battery Profile       "
ui_print "====================================="
sleep 1
ui_print " "

sleep 0.2
ui_print "====================================="
ui_print "      Install Balanced Profile       "
ui_print "====================================="
sleep 1
ui_print " "

ui_print "====================================="
ui_print "       Install Gaming Profile        "
ui_print "====================================="
sleep 1
ui_print " "

ui_print "====================================="
ui_print "      Install FPSGo & GED Param      "
ui_print "====================================="

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/vendor 0 0 0755 0755

sleep 2
ui_print "====================================="
ui_print "    Install FPSGo & GED Param OK     "
ui_print "====================================="
ui_print ""
sleep 1

ui_print "====================================="
ui_print "      Trimming System Partition      "
ui_print "====================================="
    fstrim /cache
    sleep 0.2
    fstrim /data
    sleep 0.2
    fstrim /product
    sleep 0.2
    fstrim /system
    sleep 0.2
    fstrim /vendor
    sleep 2
ui_print "+++++++++++++++++++++++++++++++++++++"
ui_print "       Trimming System Success       "
ui_print "+++++++++++++++++++++++++++++++++++++"

sleep 0.2
ui_print ""
ui_print "====================================="
ui_print "        Setting Up Permission        "
ui_print "====================================="

ui_print "==[Setting Game]=="
set_perm_recursive "$MODPATH/system/bin/game" root root 0755 0755
sleep 0.2
ui_print "==[Setting Balance]=="
set_perm_recursive "$MODPATH/system/bin/balance" root root 0755 0755
sleep 0.2
ui_print "==[Setting Battery]=="
set_perm_recursive "$MODPATH/system/bin/battery" root root 0755 0755
sleep 0.2
ui_print "==[Finalizing Setting]=="
set_perm_recursive "$MODPATH/system/bin" root root 0755 0755

sleep 2
ui_print ""
ui_print "====================================="
ui_print "     Setting Permission Success      "
ui_print "====================================="
sleep 0.2
ui_print ""
am start -a android.intent.action.VIEW -d https://t.me/yamadacookingcenter/52 >/dev/null 2>&1