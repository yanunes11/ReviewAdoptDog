public with sharing class GetAdopter2Information {

    //get Adopter Id from adoptions to Animal GetAdopter2Information.getAdopter2IdFromAdoption
    public void getAdopter2IdFromAdoption(Id animalId) {

        List<Adoption__c> adoption = [
            SELECT Id
            FROM Adoption__c
            WHERE Animal__c = :animalId
            WITH USER_MODE
        ];

        System.debug('Adoption Size: '+adoption.Size());
    }
}