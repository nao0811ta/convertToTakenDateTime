#!/bin/bash

path=$1
find_dir=$path"/*"

i=1
echo "Start"
for filename in $find_dir; do
	echo $i
	((i++))
	#rename $filename $path 
	#echo $filename
	basename=`basename $filename`
	extension="${filename##*.}"
	#echo $basename
	#echo $extension
	orin_date=`mdls "$filename" | grep ContentCreation | awk '{ date=$3" "$4" "$5; print date; }'`
	echo "date_command "$orin_date
	command="date -jf \"%Y-%m-%d %H:%M:%S %z\" \"$orin_date\" +\"%Y%m%d_%H%M%S\""
	date=$(eval "$command")
	echo "date "$date
	#echo \"$filename\" "to" $path"/SC06D_"$result"."$extension
	if [ -n "$date" ]; then
		origin_name=$path"/SC06D_"$date
		result_name=$origin_name"."$extension
		change_name=$path"/SC06D_"$date"."$extension
		if [ "$filename" == "$change_name" ]; then
			continue;			
		fi
		count=1
		while true
		do
			if [ -f "$change_name" ]; then
				echo "change name "$change_name
				new_name=$origin_name"_"$count"."$extension
				change_name=$new_name	
				echo $change_name
				((count++))
				continue;
			fi
			echo $change_name
			comman="mv \"$filename\" $change_name"
			result=$(eval "$comman")
			echo "result :"$comman
			break;
		done		
	else
		echo "date :"$date
		echo "result :"$result
		echo "extension :"$extension
		break;
	fi
done
