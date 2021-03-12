sfdx force:org:create -f config/project-scratch-def.json -d 1 -s -w 60
sfdx force:source:push
sfdx automig:load -d ./data/automig4
sfdx force:org:open 