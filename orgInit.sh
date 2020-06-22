# sfdx force:org:create -f config/project-scratch-def.json -d 1 -s
sfdx shane:org:create -f config/snapshot-project-scratch-def.json -d 1 -s -n --userprefix concierge --userdomain work.shop
sfdx force:data:record:update -s User -w "Name='User User'" -v "UserPermissionsKnowledgeUser=true"

sfdx force:source:push
sfdx force:user:permset:assign -n solutions
sfdx force:data:bulk:upsert -f data/Knowledge__kav.csv -i id -s Knowledge__kav --wait 30

sfdx force:apex:execute -f scripts/conciergeSetup.cls

sfdx force:org:open