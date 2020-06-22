# sfdx force:org:create -f config/project-scratch-def.json -d 1 -s
sfdx shane:org:create -f config/snapshot-project-scratch-def.json -d 1 -s -n --userprefix concierge --userdomain work.shop

# to get access to audit field create
sfdx force:source:deploy -p securityStuff/
sfdx force:data:record:update -s User -w "Name='User User'" -v "UserPermissionsKnowledgeUser=true"

sfdx force:source:push
sfdx force:user:permset:assign -n solutions
sfdx force:data:bulk:upsert -f data/Knowledge__kav.csv -i id -s Knowledge__kav --wait 30

sfdx force:apex:execute -f scripts/conciergeSetup.cls

sfdx shane:data:favorite -o Knowledge__kav -w "title='Flickering Monitor'"
sfdx shane:listview:favorite -t Open_IT_Tickets -o Case
sfdx shane:tab:favorite -t cncrgdemo__Concierge_LEX_Tab -l "Conciege in Lightning"
sfdx shane:tab:favorite -t cncrgdemo__Concierge -l "Conciege Standalone"

sfdx force:org:open -p lightning/n/cncrgdemo__Concierge_LEX_Tab