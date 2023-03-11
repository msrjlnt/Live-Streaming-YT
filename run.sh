#!/bin/bash

# Konfigurasi youtube dengan resolusi 720p. Video tidak di-scaled.
VBR="2500k"                                    
FPS="30"                                       
QUAL="medium"                                  
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  

# Masukkan path file video yang ingin di-loop
SOURCE="video.mp4" 

# Masukkan kunci yang diberikan oleh youtube pada event streaming
KEY="<your key>"   

# Loop ffmpeg secara terus-menerus menggunakan perintah while dan sleep
while true; do
    ffmpeg \
        -i "$SOURCE" -deinterlace \
        -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
        -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
        -f flv "$YOUTUBE_URL/$KEY" \

    # Tidur selama 2 detik sebelum melakukan iterasi berikutnya
    sleep 2
done
