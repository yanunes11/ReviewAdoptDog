@IsTest
public with sharing class AnimalQueriesTest {
    @TestVisible
    private static Integer numberOfRecords = 10;
    
    @TestSetup
    static void makeData(){
        List<Adopter__c> adopterList = TestDataFactory.createAdotperList(numberOfRecords);
        insert adopterList;
        List<Animal__c> animalList = TestDataFactory.createAnimalList(numberOfRecords);
        insert animalList;
    }

    @IsTest
    public static void getAnimalInformationByIdTest() {
        Animal__c animal = [
            SELECT Id, Name
            FROM Animal__c
            LIMIT 1
        ];
        Test.startTest();
        Animal__c animalResponse = AnimalQueries.getAnimalInformationById(String.valueOf(animal.Id));
        Test.stopTest();
        System.assertEquals(animalResponse.Id, animal.Id, 'The animals are different.');
    }

    @IsTest
    public static void getAvailableAnimalListTest() {
        Animal__c animal = [
            SELECT Id
            FROM Animal__c
            LIMIT 1
        ];
        Adopter__c adopter = [
            SELECT Id
            FROM Adopter__c
            LIMIT 1
        ];
        Adoption__c adoption = new Adoption__c(Animal__c = animal.Id, Adopter__c = adopter.Id, Adoption_Stage__c = 'Adopted');
        //It has been created 10 animals on makeData without creating any adoption. Now the code creates 1 adoption and 9 animals will be available.
        insert adoption;
        Map<String, AnimalQueries.FieldProperty> mapResponse = new Map<String, AnimalQueries.FieldProperty>();
        Test.startTest();
        mapResponse = (Map<String, AnimalQueries.FieldProperty>) AnimalQueries.getAvailableAnimalList();
        Test.stopTest();
        System.assertEquals(numberOfRecords - 1, mapResponse.Size(), 'The response should be shown only available animals.');
    }
}