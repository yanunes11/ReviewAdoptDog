public with sharing class AnimalQueries {

    @AuraEnabled (cacheable = true)
    public static Animal__c getAnimalInformationById(String animalId) {
        Animal__c animal = [
            SELECT Id, Name, Adopter_Name__c
            FROM Animal__c
            WHERE Id = :Id.valueOf(animalId)
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        return animal;
    }
}