
# 兼容 32 和 64 包体积增加一半
# flutter build apk --target-platform android-arm64 --dart-define=APP_CHANNEL=$1 --dart-define=OTHER_VAR=$2

# 只支持 23位
# flutter build apk --target-platform=android-arm --dart-define=APP_CHANNEL=$1 --dart-define=OTHER_VAR=$2 --dart-define=AndroidArm==$3

# # 支持 64位
# flutter build apk --target-platform android-arm64 --dart-define=APP_CHANNEL=$1 --dart-define=OTHER_VAR=$2 --dart-define=AndroidArm==$3

if (($3 == 32)); then
    echo "32位打包"
    flutter build apk --no-tree-shake-icons --target-platform=android-arm --dart-define=APP_CHANNEL=$1 --dart-define=OTHER_VAR=$2 --dart-define=ANDROID_ARM=$3
elif (($3 == 64)); then
    echo "64位打包"
    flutter build apk --no-tree-shake-icons --target-platform android-arm64 --dart-define=APP_CHANNEL=$1 --dart-define=OTHER_VAR=$2 --dart-define=ANDROID_ARM=$3
else 
    echo "32和64位兼容打包"
    flutter build apk  --dart-define=APP_CHANNEL=$1 --dart-define=OTHER_VAR=$2 --dart-define=ANDROID_ARM=$3
fi




cd /Users/as/Desktop/gongzuo/sales_secretary_flutter/build/app/outputs/apk/release

mv -f *.apk /Users/as/Desktop/gongzuo/sales_secretary_flutter/shell/build