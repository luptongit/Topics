public with sharing class clsTopics {
    public clsTopics() {}

    @AuraEnabled
    public static List<Topic_Resource__c> getAllTopics()
    {

        List<Topic_Resource__c> existingAssignments = [SELECT Id, Topic__r.Name FROM Topic_Resource__c];
        return existingAssignments;

    }
    
    @InvocableMethod(label='Assign Digital Resource to all Salesforce Features' description='' category='Topics')
   public static void assignDigitalResourceToAllSalesforceFeatures(List<Id>  digitalResources) {
     
    Id digitalResource = digitalResources[0];
    List<Topic_Resource__c> existingTopicResource = [SELECT Id FROM Topic_Resource__c WHERE Resource__c = :digitalResource];
    delete existingTopicResource;
      
    List<Topic__c> topics = [SELECT Id FROM Topic__c WHERE Type__c = 'Salesforce Feature'];
    for (Topic__c topic : topics) {
       
      Topic_Resource__c newTopicResource = new Topic_Resource__c();
        newTopicResource.Topic__c = topic.Id;
        newTopicResource.Resource__c = digitalResource;
        existingTopicResource.add(newTopicResource);
      
    }
      
    insert existingTopicResource;
      
  }

    
}