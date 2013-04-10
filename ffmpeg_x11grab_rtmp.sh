#blam!

INRES="1280x800"
OUTRES="640x400"
FPS="15"
QUAL="ultrafast"

URL="rtmp://micronemez.com/live/ezz"

ffmpeg -f x11grab -y -s "$INRES" -r "$FPS" -i :0.0 -an \
-vcodec libx264 -preset "$QUAL" -crf 30 -s "$OUTRES" -b:v 1500k \
-f flv "$URL"
