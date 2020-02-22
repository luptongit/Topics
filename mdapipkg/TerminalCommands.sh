sfdx force:org:list
sfdx force:mdapi:retrieve -s -r ./mdapipkg -u jlupton-xpnc@force.com -p Topics
unzip ./mdapipkg/unpackaged.zip -d ./mdapipkg/source
force:mdapi:convert --rootdir mdapipkg/source
sfdx force:alias:list
sfdx force:data:soql:query -q "SELECT Description__c,Name,Type__c FROM Topic__c" -u DevHub -r csv 
sfdx force:data:bulk:upsert -s Topic__c -f ./data/TopicData.csv -i Id -u Topics

SELECT Description__c,Private__c,Resource_Type__c,Source__c,Url__c FROM Digital_Resource__c
SELECT Private__c,Resource__c,Topic__c FROM Topic_Resource__c

git remote add origin https://github.com/luptongit/SalesforceInvokableFlow.git

sfdx force:data:tree:export -q "SELECT Name, Description__c, Type__c, 
(SELECT Name,  Topic__c, Private__c, 
        Resource__r.Name, Resource__r.Resource_Type__c, 
        Resource__r.Url__c,
        Resource__r.Private__c,
        Resource__r.Description__c,
        Resource__r.Source__c 
FROM Topic_Resources__r) FROM Topic__c" -d ./data/json -u DevHub --prefix package_data --plan

sfdx force:data:tree:export -q "SELECT Name, Description__c, Type__c, 
(SELECT Name,  Private__c FROM Topic_Resources__r) FROM Topic__c" -d ./data/json -u DevHub --prefix package_data --plan

sfdx force:data:tree:export -q "SELECT Name, Resource_Type__c, Url__c, Private__c, Description__c, Source__c, (SELECT Name,  Private__c FROM Topic_Resources1__r) FROM Digital_Resource__c" -d ./data/json -u DevHub --prefix package_data --plan

sfdx force:data:tree:export -q "SELECT Name, Description__c, Type__c FROM Topic__c" -d ./data/json -u DevHub --prefix package_data --plan
sfdx force:data:tree:export -q "SELECT Name, Resource_Type__c, Url__c, Private__c, Description__c, Source__c FROM Digital_Resource__c" -d ./data/json -u DevHub --prefix package_data --plan
sfdx force:data:tree:export -q "SELECT Name, Resource__r.Id, Topic__r.Id, Private__c FROM Topic_Resource__c" -d ./data/json -u DevHub --prefix package_data --plan

sfdx force:data:tree:import -u Topics --plan ./data/json/package_data-Topic__c-plan.json

