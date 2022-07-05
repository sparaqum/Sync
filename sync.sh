
#!/bin/bash


#Enter Ur BackUp Folder Location
BackUp_Dir="/home/paraqum/Paraqum/BackUp/"

# Store Tracked files by Git to y
x="git ls-files"
y=$(eval "$x")

# Get pwd and Display date
Current_Dir=$(eval pwd)
echo $(date)
echo -e "\e[1;36m..Files and Subdirectories..\e[0m"

# Acess the All Directories in the pwd
cd $Current_Dir &&
find . -not -name ".*" -type d -exec mkdir -p -- $BackUp_Dir{} \;


for item in $y
do
	echo " $item"
	cp -ar $item $BackUp_Dir/$item 
		
done


# Remove Hidden Directories
#rm -r $BackUp_Dir.*

