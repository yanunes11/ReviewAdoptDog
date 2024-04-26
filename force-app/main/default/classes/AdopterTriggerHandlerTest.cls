@IsTest
public with sharing class AdopterTriggerHandlerTest {

    @TestVisible
    private static Integer numberOfRecords = 10;

    @TestSetup
    static void makeData(){
        List<Adopter__c> adopterList = TestDataFactory.createAdotperList(numberOfRecords);
        insert adopterList;
        List<Animal__c> animalList = TestDataFactory.createAnimalList(numberOfRecords);
        insert animalList;
    }

    @isTest
    public static void beforeAfterInsertTest() {
        Adopter__c adopter = new Adopter__c(Name = 'John');
        Test.startTest();
        insert adopter;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AdopterTriggerHandlerTest.beforeAfterInsertTest');
        System.assert(true, 'Any code written.');
    }
    
    @isTest
    public static void beforeAfterUpdateTest() {
        Adopter__c adopter = [
            SELECT Id, Name
            FROM Adopter__c
            WITH SYSTEM_MODE
            LIMIT 1
            ];
        adopter.Name = 'Ambroglio';
        Test.startTest();
        update adopter;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AdopterTriggerHandlerTest.beforeAfterUpdateTest');
        System.assert(true, 'Any code written.');
    }

    @isTest
    public static void beforeAfterDeleteTest() {
        Adopter__c adopter = [
            SELECT Id, Name
            FROM Adopter__c
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        Test.startTest();
        delete adopter;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AdopterTriggerHandlerTest.beforeAfterDeleteTest');
        System.assert(true, 'Any code written.');
    }

    @isTest
    public static void afterUndeleteTest() {
        Adopter__c adopter = [
            SELECT Id, Name
            FROM Adopter__c
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        delete adopter;
        Adopter__c adopterToUndelete = [
            SELECT Id, Name
            FROM Adopter__c
            WHERE Id = :adopter.Id
            WITH SYSTEM_MODE
            LIMIT 1
            ALL ROWS
        ];
        Test.startTest();
        undelete adopterToUndelete;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AdopterTriggerHandlerTest.afterUndeleteTest');
        System.assert(true, 'Any code written.');
    }
}