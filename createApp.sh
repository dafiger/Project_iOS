#!/bin/bash

git clone https://github.com/dafiger/Project_iOS.git 

Cyan='\033[0;36m'
Default='\033[0;m'

projectName=""
organizationName=""
confirmed="n"

getProjectName() {
    read -p "请输入项目名: " projectName

    if test -z "$projectName"; then
        getProjectName
    fi
}

getOrganizationName() {
    read -p "请输入组织名: " organizationName

    if test -z "$organizationName"; then
        getOrganizationName
    fi
}

getInfomation() {
    getProjectName
    getOrganizationName

    echo -e "\n${Default}================================================"
    echo -e "  Project Name       :  ${Cyan}${projectName}${Default}"
    echo -e "  Organization Name  :  ${Cyan}${organizationName}${Default}"
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

cp -r "./Project_iOS" "./${projectName}"
mv "./${projectName}/Project_iOS" "./${projectName}/${projectName}"
mv "./${projectName}/Project_iOS.xcodeproj" "./${projectName}/${projectName}.xcodeproj"

licenseFilePath="./${projectName}/LICENSE"
gitignoreFilePath="./${projectName}/.gitignore"
readmeFilePath="./${projectName}/readme.md"
podfilePath="./${projectName}/Podfile"

pbxprojPath="./${projectName}/${projectName}.xcodeproj/project.pbxproj"
xcworkspacedataPath="./${projectName}/${projectName}.xcodeproj/project.xcworkspace/contents.xcworkspacedata"

#修改
echo "editing..."
sed -i "" "s%Project_iOS%${projectName}%g" "$gitignoreFilePath"

sed -i "" "s%Project_iOS%${projectName}%g" "$readmeFilePath"

sed -i "" "s%Project_iOS%${projectName}%g" "$podfilePath"

sed -i "" "s%Project_iOS%${projectName}%g" "$pbxprojPath"
sed -i "" "s%dafiger%${organizationName}%g" "$pbxprojPath"

sed -i "" "s%Project_iOS%${projectName}%g" "$xcworkspacedataPath"

echo "edit finished"

echo "cleaning..."
cd ./$projectName

rm .DS_Store       #--cached &> /dev/null
rm -rf $projectName.xcodeproj/xcuserdata/* # &> /dev/null
rm -rf $projectName.xcodeproj/project.xcworkspace/xcuserdata/* # &> /dev/null
rm -rf $projectName.xcodeproj/project.xcworkspace/xcshareddata/* # &> /dev/null
echo "clean finished"

echo "finished"
