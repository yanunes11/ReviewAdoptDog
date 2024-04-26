@IsTest
public with sharing class AdopterQueriesTest {
    @TestSetup
    static void makeData(){
        List<Adopter__c> adopterList = TestDataFactory.createAdotperList(10);
        insert adopterList;
        List<Animal__c> animalList = TestDataFactory.createAnimalList(10);
        insert animalList;
    }

    @IsTest
    public static void getAdopterInformationByIdTest() {
        Adopter__c adopter = [
            SELECT Id
            FROM Adopter__c
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        Test.startTest();
        Adopter__c adopterInfo = AdopterQueries.getAdopterInformationById(adopter.Id);
        Test.stopTest();
        System.assertEquals(adopter.Id, adopterInfo.Id, 'It\'s been retrieved a wrong animal.');
    }

    @IsTest
    public static void getAdopterInformationByNullIdTest() {
        String errorMessage;
        Test.startTest();
        try {
            Adopter__c adopterInfo = AdopterQueries.getAdopterInformationById(null);
        } catch (System.NullPointerException e) {
            errorMessage = e.getMessage();
        }
        System.assert(errorMessage != null, 'It should be null.');
    }
    
    @IsTest
    public static void getAvailableAdopterListTest() {
        Map<String, AdopterQueries.FieldProperty> adopterPropertyMap;
        String errorMessage;
        Test.startTest();
        try {
            adopterPropertyMap = AdopterQueries.getAvailableAdopterList();
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
        Test.stopTest();
        System.debug('YNASC errorMessage: '+errorMessage);
        System.assertEquals(10, adopterPropertyMap.size(), 'It should not be null.');
    }
}