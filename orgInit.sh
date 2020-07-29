sfdx shane:org:create -f config/project-scratch-def.json -d 1 -s -n --userprefix concierge --userdomain de.mo
sfdx force:package:install --package 04t4P000002qm6f --noprompt --wait 50

# to get access to audit field create
sfdx force:source:deploy -p securityStuff/
# give the admin knowledge permission
sfdx force:data:record:update -s User -w "Name='User User'" -v "UserPermissionsKnowledgeUser=true"

sfdx force:source:push
sfdx force:user:permset:assign -n solutions

# add a background option to settings
sfdx force:data:record:create -s cncrgdemo2__Background_Settings__c -v "cncrgdemo2__Background_File_Type__c=Image cncrgdemo2__File_Location__c=newBackground Name=NewBackground"
sfdx force:data:bulk:upsert -f data/Knowledge__kav.csv -i id -s Knowledge__kav --wait 30

sfdx force:apex:execute -f scripts/conciergeSetup.cls

sfdx shane:data:favorite -o Knowledge__kav -w "title='Flickering Monitor'"
sfdx shane:listview:favorite -t Open_IT_Tickets -o Case
sfdx shane:listview:favorite -t published_articles -o Knowledge__kav -l "Published Articles" 
sfdx shane:tab:favorite -t cncrgdemo2__Concierge_LEX_Tab -l "Conciege in Lightning"
sfdx shane:tab:favorite -t cncrgdemo2__Concierge -l "Conciege Standalone"
sfdx shane:tab:favorite -t cncrgdemo2__Settings_Page -l "Conciege Settings"

sfdx force:org:open -p lightning/n/cncrgdemo2__Concierge_LEX_Tab