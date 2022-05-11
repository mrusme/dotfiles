#!/bin/sh

if [[ "$1" == "" || "$2" == "" || "$3" == "" ]]
then
  echo "usage: $0 <sauce dir> <dest dir> <format>"
  exit 1
fi

sauce_dir=$1
dest_dir=$2
format=$3

find "$sauce_dir" -type f -regex '.*\.'$format'$' | while read f
do
  file_name=$(basename "$f")

  tags=$(exiftool -artist -title -audiobitrate "$f" | awk -F ': ' '{ print $2 }')
  

  tagsNr=$(echo "$tags" | wc -l)

  artist=$(echo "$tags" | head -n 1)
  title=$(echo "$tags" | head -n 2 | tail -n 1)
  bitrate=$(echo "$tags" | tail -n 1 | sed 's/ //g')

  if [ "$tagsNr" == "2" ]
  then
    bitrate="000kbps"
  fi

  artist_clean=$(echo "$artist" | tr '[A-Z]' '[a-z]' | sed -E 's/[^0-9a-zA-Z.-]/_/g')
  title_clean=$(echo "$title" | tr '[A-Z]' '[a-z]' | sed -E 's/[^0-9a-zA-Z.-]/_/g')

  new_dir="$dest_dir/$artist_clean"
  new_file="$new_dir/$artist_clean-$title_clean-$bitrate.$format"

  if [[ "$f" == "$new_file" ]]
  then
    echo "NO CHANGE: $f"
  else
    mkdir -p "$new_dir"
    mv -v "$f" "$new_file"
  fi

  if [ $? != 0 ]
  then 
    echo "ERROR: $f   -x->   $new_file"
    exit 1
  fi
done

echo ""
echo "All done."

exit 0
