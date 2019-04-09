#!/bin/bash


Cyan='\033[0;36m'
Default='\033[0;m'

version=""
confirmed="n"
getVersion() {
    read -p "请输入提交版本号: " version

    if test -z "$version"; then
        getVersion
    fi
}

getInfomation() {
getVersion

echo -e "\n${Default}================================================"
echo -e "  Version  :  ${Cyan}${version}${Default}"
echo -e "================================================\n"
}

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
getInfomation
fi
read -p "确定? (y/n):" confirmed
done

git add .
git commit -m "update to tag:${version}"
git push origin master -f 
git tag $version
git push --tags
say "finished"
echo "finished"
