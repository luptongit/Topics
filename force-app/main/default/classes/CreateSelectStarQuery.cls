public with sharing class CreateSelectStarQuery {
    public CreateSelectStarQuery() {
        // This is the object for which we required data.
        Map<String, Schema.SObjectField> fieldMap = Topic.sObjectType.getDescribe().fields.getMap();
        
        // Get all of the fields on the object
        Set<String> fieldNames = fieldMap.keySet();
        
        // Build a Dynamic Query String.
        // List<Topic> opps = Database.query('select ' + string.join(fieldNames, ',') + ' from Topic');

        string topicQuery = 'select ' + string.join(fieldNames, ',') + ' from Topic';

        System.debug(topicQuery);
    }
}
