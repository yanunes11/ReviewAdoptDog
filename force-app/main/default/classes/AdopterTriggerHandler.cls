public with sharing class AdopterTriggerHandler implements TriggerHandler {
    private map<Id, Animal__c> newMap;
    private map<Id, Animal__c> oldMap;

    private Boolean triggerIsExecuting;
    private Integer triggerSize;
    private String operationType;
    public AdopterTriggerHelper helper;

    public AdopterTriggerHandler(Boolean triggerIsExecuting, Integer triggerSize, String operationType, List<Adopter__c> newAdopters, List<Adopter__c> oldAdopters, Map<ID, SObject> newAdopterMap, Map<ID, SObject> oldAdopterMap) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.operationType = operationType;
        this.helper = new AdopterTriggerHelper();
        System.debug('operatioType: '+this.operationType);
        switch on operationType {
            when  'AFTER_INSERT' {
                afterInsert(newAdopters, newAdopterMap);
            }
            when else {
                afterUpdate(oldAdopters, newAdopters, oldAdopterMap, newAdopterMap);
            }
        }
    }

    public void beforeInsert(List<Adopter__c> newAdopters) {
        System.debug('');
        // helper.doTask1();matt pla
        // helper.doTask2();
    }
    public void beforeUpdate(List<Adopter__c> oldAdopters, List<Adopter__c> newAdopters, Map<ID, SObject> oldAdopterMap, Map<ID, SObject> newAdopterMap) {
        System.debug('');
        // helper.doTask3();
        // helper.doTask4();
    }
    public void beforeDelete(List<Adopter__c> oldAdopters, Map<ID, SObject> oldAdopterMap) {
        System.debug('');
        // helper.doTask5();
        // helper.doTask1();
    }
    public void afterInsert(List<Adopter__c> newAdopters, Map<ID, SObject> newAdopterMap) {
        System.debug('');
        // helper.doTask2();
        // helper.doTask3();
    }
    public void afterUpdate(List<Adopter__c> oldAdopters, List<Adopter__c> newAdopters, Map<ID, SObject> oldAdopterMap, Map<ID, SObject> newAdopterMap) {
        System.debug('');
        // helper.doTask4();
        // helper.doTask5();
    }
    public void afterDelete(List<Adopter__c> oldAdopters, Map<ID, SObject> oldAdopterMap) {
        System.debug('');
        // helper.doTask3();
        // helper.doTask1();
    }
    public void afterUndelete(List<Adopter__c> newAdopters, Map<ID, SObject> newAdopterMap) {
        System.debug('');
        // helper.doTask4();
        // helper.doTask2();
    }
}