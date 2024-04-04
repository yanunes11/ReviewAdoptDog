/*
    * @author : Yan Nascimento
    * @Date : 2024/03/25
    * @Description : handle the trigger for Adoption object.
    * @log : 2024/03/25 - created
*/
public with sharing class AdoptionTriggerHandler {
    private List<Adoption__c> newValuesList;
    private List<Adoption__c> oldValuesList;
    private Map<Id, Adoption__c> newMap;
    private Map<Id, Adoption__c> oldMap;
    private Map<String, List<Adoption__c>> newOldValuesListMap;
    private Map<String, Map<Id, Adoption__c>> newOldValuesMap;
    private String operationType;

    public AdoptionTriggerHandler(String operationType, Map<String, List<Adoption__c>> newOldValuesListMap, Map<String, Map<Id, Adoption__c>> newOldValuesMap) {
        System.debug('YNASC AdoptionTriggerHandler');
        this.newValuesList = newOldValuesListMap.get('new');
        this.oldValuesList = newOldValuesListMap.get('old');
        this.newMap = newOldValuesMap.get('newMap');
        this.oldMap = newOldValuesMap.get('oldMap');
        this.newOldValuesListMap = newOldValuesListMap;
        this.newOldValuesMap = newOldValuesMap;
        this.operationType = operationType;
    }

    public void switchOperationType() {
        System.debug('YNASC operatioType: '+this.operationType);
        switch on operationType {
            when 'BEFORE_INSERT' {
                beforeInsert(newValuesList);
            } 
            when 'BEFORE_UPDATE' {
                beforeUpdate(newOldValuesListMap, newOldValuesMap);
            }
            when else {
                System.debug('when else');
            }
        }
    }

    public void beforeInsert(List<Adoption__c> newRecords) {
        System.debug('YNASC beforeInsert');
        AdoptionTriggerHelper.checkInsertAnimalHasBeenAdopted(newRecords);
    }
    public void beforeUpdate(Map<String, List<Adoption__c>> newOldAdoptions, Map<String, Map<Id, Adoption__c>> newOldAdoptionsMap){
        System.debug('YNASC beforeUpdate');
        AdoptionTriggerHelper.checkUpdateAnimalHasBeenAdopted(newOldAdoptions, newOldAdoptionsMap);
    }
    public void beforeDelete(List<Adoption__c> oldRecords, Map<ID, Adoption__c> oldRecordMap){System.debug('YNASC beforeDelete');}
    public void afterInsert(List<Adoption__c> newRecords, Map<ID, Adoption__c> newRecordMap){System.debug('YNASC afterInsert');}
    public void afterUpdate(Map<String, List<Adoption__c>> newOldAdoptions, Map<String, Map<Id, Adoption__c>> newOldAdoptionsMap){System.debug('YNASC afterUpdate');}
    public void afterDelete(List<Adoption__c> oldRecords, Map<ID, Adoption__c> oldRecordMap){System.debug('YNASC afterDelete');}
    public void afterUndelete(List<Adoption__c> newRecords, Map<ID, Adoption__c> newRecordMap){System.debug('YNASC afterUndelete');}
}