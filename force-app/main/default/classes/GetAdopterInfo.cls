public with sharing class GetAdopterInfo {

    //get Adopter Id from adoptions to Animal GetAdopter2Information.getAdopter2IdFromAdoption
    public static Map<String, String> getAdopterIdFromAdoption(Id animalId) {

        Adoption__c adoption = [
            SELECT Id, Adopter__r.Id, Adopter__r.Name
            FROM Adoption__c
            WHERE Animal__c = :animalId
            WITH USER_MODE
            LIMIT 1
        ];
        System.debug('Adopter Name: '+adoption.Adopter__r.Name);
        Map<String, String> adopterMap = new Map<String,String>();
        adopterMap.put(adoption.Adopter__r.Id, adoption.Adopter__r.Name);

        return adopterMap;
    }
}