ffmpeg -i $1 -vcodec libx264 -b:v 150k -s 640*480 -c:a aac -strict experimental -b:a 128k $2