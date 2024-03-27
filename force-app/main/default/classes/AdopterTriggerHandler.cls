public with sharing class AdopterTriggerHandler implements TriggerHandler {
    private List<Adopter__c> newValues;
    private List<Adopter__c> oldValues;
    private map<Id, Adopter__c> newMap;
    private map<Id, Adopter__c> oldMap;
    private String operationType;
    
    public AdopterTriggerHelper helper;

    public AdopterTriggerHandler(String operationType, Map<String, List<Adopter__c>> newOldValues, Map<String, Map<Id, Adopter__c>> newOldValuesMap) {
        this.newValues = newOldValues.get('new');
        this.oldValues = newOldValues.get('old');
        this.newMap = newOldValuesMap.get('newMap');
        this.oldMap = newOldValuesMap.get('oldMap');
        this.operationType = operationType;
        this.helper = new AdopterTriggerHelper();
        switchOperationType(operationType, newOldValues, newOldValuesMap);
    }

    public void switchOperationType(String operationType, Map<String, List<Adopter__c>> newOldValues, Map<String, Map<Id, Adopter__c>> newOldValuesMap) {
        System.debug('operatioType: '+this.operationType);
        switch on operationType {
            when  'AFTER_INSERT' {
                afterInsert(newValues, newMap);
            }
            when else {
                afterUpdate(newOldValues, newOldValuesMap);
            }
        }
    }

    public void beforeInsert(List<Adopter__c> newAdopters) {
        System.debug('beforeInsert');
    }
    public void beforeUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap) {
        System.debug('beforeUpdate');
    }
    public void beforeDelete(List<Adopter__c> oldAdopters, Map<ID, SObject> oldAdopterMap) {
        System.debug('beforeDelete');
    }
    public void afterInsert(List<Adopter__c> newAdopters, Map<ID, SObject> newAdopterMap) {
        System.debug('afterInsert');
        helper.getAdopterNameToInsertOnAnimal();
    }
    public void afterUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap) {
        System.debug('afterUpdate');
        helper.getAdopterNameToInsertOnAnimal();
    }
    public void afterDelete(List<Adopter__c> oldAdopters, Map<ID, SObject> oldAdopterMap) {
        System.debug('afterDelete');
    }
    public void afterUndelete(List<Adopter__c> newAdopters, Map<ID, SObject> newAdopterMap) {
        System.debug('afterUndelete');
    }
}