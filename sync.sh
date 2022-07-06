
#!/bin/bash


#Enter Ur BackUp Folder Location
BackUp_Dir="/home/paraqum/Paraqum/BackUp_2/"

# Store Tracked files by Git to y
x="git ls-files"
y=$(eval "$x")

# Get pwd and Display date
Current_Dir=$(eval pwd)
echo $(date)

# Acess the All Directories in the pwd
cd $Current_Dir &&
find . -not -name ".*" -type d -exec mkdir -p -- $BackUp_Dir{} \;

echo -e "\e[1;36m..Synced Files and subdirectories..\e[0m"
# Check whether same file exit in the BackUp Directory
for item in $y; do

	if [[ -f $item ]] && [[ -f $BackUp_Dir/$item ]]; then
    
		# echo "$BackUp_Dir/$item"
		cmp --silent -- $item $BackUp_Dir/$item || echo "$item is modified." && cp -ar $item $BackUp_Dir/$item

    else
	  	echo "$item is newly added to BackUp"
		cp -ar $item $BackUp_Dir/$item 
    fi
done

# Check there is any file that is not in the Current_Dir and remove them from the BackUp_Dir.
echo -e "\n\n\e[1;32m..Removed Files from BackUp..\e[0m"

for file in $(find $BackUp_Dir -type f -not -name '*.git');
do
    filestr=`basename $file`

    if [ `ls -LR $Current_Dir | grep -c $filestr` -eq 0 ]; then
    	rm $file
        echo "$filestr is removed from the $file"       
    fi
done



