/*
    * @author : Yan Nascimento
    * @Date : 2024/04/23
    * @Description : helper class to handle the trigger for Animal object.
    * @log : 2024/04/23 - created
*/
public with sharing class AnimalTriggerHelper {
    public static void  mainMethod(TriggerDataDTO triggerData) {
        Map<Id, Animal__c> newMap = (Map<Id, Animal__c>) triggerData.getMapNew();
        Map<Id, Animal__c> oldMap = (Map<Id, Animal__c>) triggerData.getMapOld();
        System.debug('YNASC mainMethod');
    }
}