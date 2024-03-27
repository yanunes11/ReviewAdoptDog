public with sharing class AdoptionTriggerHandler {
    private List<Adoption__c> newValues;
    private List<Adoption__c> oldValues;
    private Map<Id, Adoption__c> newMap;
    private Map<Id, Adoption__c> oldMap;
    private Map<String, List<Adoption__c>> newOldValues;
    private Map<String, Map<Id, Adoption__c>> newOldValuesMap;
    private String operationType;

    public AdoptionTriggerHandler(String operationType, Map<String, List<Adoption__c>> newOldValues, Map<String, Map<Id, Adoption__c>> newOldValuesMap) {
        System.debug('YNASC AdoptionTriggerHandler');
        this.newValues = newOldValues.get('new');
        this.oldValues = newOldValues.get('old');
        this.newMap = newOldValuesMap.get('newMap');
        this.oldMap = newOldValuesMap.get('oldMap');
        this.newOldValues = newOldValues;
        this.newOldValuesMap = newOldValuesMap;
        this.operationType = operationType;
    }

    public void switchOperationType() {
        System.debug('YNASC operatioType: '+this.operationType);
        switch on operationType {
            when  'AFTER_INSERT' {
                afterInsert(newValues, newMap);
            }
            when else {
                afterUpdate(newOldValues, newOldValuesMap);
            }
        }
    }

    public void beforeInsert(List<Adoption__c> newRecords) {System.debug('YNASC beforeInsert');}
    public void beforeUpdate(Map<String, List<Adoption__c>> newOldAdoptions, Map<String, Map<Id, Adoption__c>> newOldAdoptionsMap){
        System.debug('YNASC beforeInsert');
    }
    public void beforeDelete(List<Adoption__c> oldRecords, Map<ID, Adoption__c> oldRecordMap){System.debug('YNASC beforeInsert');}
    public void afterInsert(List<Adoption__c> newRecords, Map<ID, Adoption__c> newRecordMap){System.debug('YNASC beforeInsert');}
    public void afterUpdate(Map<String, List<Adoption__c>> newOldAdoptions, Map<String, Map<Id, Adoption__c>> newOldAdoptionsMap){
        System.debug('YNASC beforeInsert');
    }
    public void afterDelete(List<Adoption__c> oldRecords, Map<ID, Adoption__c> oldRecordMap){System.debug('YNASC beforeInsert');}
    public void afterUndelete(List<Adoption__c> newRecords, Map<ID, Adoption__c> newRecordMap){System.debug('YNASC beforeInsert');}
}