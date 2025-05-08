#!/bin/sh

cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

! command -v ffmpeg \
    && "This script requires ffmpeg to work!" && exit 1
! command -v curl \
    && "This script requires scp to work!" && exit 1

image_path="img.jpg"
api_key="$(cat apikey.txt)"
media_source="$(cat mediasource.txt)"
image_width="1280"
api_endpoint="https://kattila-api.linkkijkl.fi/coffee/image"

ffmpeg -y -i "$media_source" -vf scale="$image_width":-1 "$image_path"

curl -X PUT --header "X-API-Key: $api_key" -F "file=@$image_path" -v "$api_endpoint"
