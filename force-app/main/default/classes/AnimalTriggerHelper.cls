/*
    * @author : Yan Nascimento
    * @Date : 2024/04/23
    * @Description : helper class to handle the trigger for Animal object.
    * @log : 2024/04/23 - created
*/
public with sharing class AnimalTriggerHelper {
    public static void  avoidCreateAdopterDirectlyOnAnimal(TriggerDataDTO triggerData) {
        List<Animal__c> newAnimalList = (List<Animal__c>) triggerData.getNewValues();
        List<Animal__c> oldAnimalList = (List<Animal__c>) triggerData.getOldValues();

    }
}