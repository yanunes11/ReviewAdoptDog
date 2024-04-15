public with sharing class AdopterQueries {

    @AuraEnabled
    public static Adopter__c getAdopterInformationById(String adopterId){
        System.debug('YNASC Insed');
        Adopter__c adopter = [
            SELECT Id, Name
            FROM Adopter__c
            WHERE Id = :Id.valueOf(adopterId)
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        System.debug('YNASC adopter: '+adopter);
        return adopter;
    }
}