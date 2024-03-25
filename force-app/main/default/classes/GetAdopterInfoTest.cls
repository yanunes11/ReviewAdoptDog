@IsTest
public with sharing class GetAdopterInfoTest {

    @TestSetup
    static void makeData(){
        Animal__c animal = new Animal__c(Name = 'Pimpolho');
        insert animal;

        Adopter__c adopter = new Adopter__c(Name = 'Juliano');
        insert adopter;

        Adoption__c adoption = new Adoption__c(
            Animal__c = animal.Id,
            Adopter__c = adopter.Id
        );
        insert adoption;
    }

    @IsTest
    public static void getAdopterIdTest() {
        Animal__c animal = [
            SELECT Id
            FROM Animal__c
            WITH USER_MODE
            LIMIT 1
        ];
        Adopter__c adopter = [
            SELECT Id
            FROM Adopter__c
            WITH USER_MODE
            LIMIT 1
        ];
        Adoption__c adoption = [
            SELECT Id, Adopter__r.Id, Adopter__r.Name
            FROM Adoption__c
            WHERE Animal__c = :animal.Id
            WITH USER_MODE
            LIMIT 1
        ];

        Test.startTest();
        Map<String, String> adopterMapInfo = GetAdopterInformation.getAdopterIdFromAdoption(animal.Id);
        Test.stopTest();
        String adopterId = new List<String> (adopterMapInfo.keySet()).get(0);
        
        System.assertEquals(String.valueOf(adopter.Id), adopterId, 'Adoption don\'t match to the right Adopter');
    }
}