/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : handle the trigger for Adopter object.
    * @log : 2024/03/25 - created
*/
public with sharing class AdopterTriggerHandler implements TriggerHandler {
    private List<Adopter__c> newValues;
    private List<Adopter__c> oldValues;
    private Map<Id, Adopter__c> newMap;
    private Map<Id, Adopter__c> oldMap;
    private Map<String, List<Adopter__c>> newOldValues;
    private Map<String, Map<Id, Adopter__c>> newOldValuesMap;
    private String operationType;

    //Constructor
    public AdopterTriggerHandler(String operationType, Map<String, List<Adopter__c>> newOldValues, Map<String, Map<Id, Adopter__c>> newOldValuesMap) {
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

    public void beforeInsert(List<Adopter__c> newAdopters) {
        System.debug('YNASC beforeInsert');
    }
    public void beforeUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap) {
        System.debug('YNASC beforeUpdate');
    }
    public void beforeDelete(List<Adopter__c> oldAdopters, Map<ID, SObject> oldAdopterMap) {
        System.debug('YNASC beforeDelete');
    }
    public void afterInsert(List<Adopter__c> newAdopters, Map<ID, SObject> newAdopterMap) {
        System.debug('YNASC afterInsert');
        AdopterTriggerHelper.getAdopterNameToInsertOnAnimal();
    }
    public void afterUpdate(Map<String, List<SObject>> newOldAdopters, Map<String, Map<Id, SObject>> newOldAdoptersMap) {
        System.debug('YNASC afterUpdate');
        AdopterTriggerHelper.getAdopterNameToInsertOnAnimal();
    }
    public void afterDelete(List<Adopter__c> oldAdopters, Map<ID, SObject> oldAdopterMap) {
        System.debug('YNASC afterDelete');
    }
    public void afterUndelete(List<Adopter__c> newAdopters, Map<ID, SObject> newAdopterMap) {
        System.debug('YNASC afterUndelete');
    }
}