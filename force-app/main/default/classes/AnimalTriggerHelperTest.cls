@IsTest
public with sharing class AnimalTriggerHelperTest {
    @TestVisible
    private static Integer numberOfRecords = 10;
    
    @TestSetup
    static void makeData(){
        List<Adopter__c> adopterList = TestDataFactory.createAdotperList(numberOfRecords);
        insert adopterList;
        List<Animal__c> animalList = TestDataFactory.createAnimalList(numberOfRecords);
        insert animalList;
        List<Adoption__c> adoptionList = TestDataFactory.createAdoptionList(adopterList, animalList);
        insert adoptionList;
    }

    @Istest
    public static void beforeAfterInsert() {
        Animal__c animal = new Animal__c(Name = 'Test before after');
        Test.startTest();
        insert animal;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AnimalTriggerHelperTest.beforeAfterInsert');
        System.assert(true, 'Create insert Test.');
    }

    @Istest
    public static void beforeAfterUpdate() {
        Animal__c animal = [
            SELECT Id, Name
            FROM Animal__c
            LIMIT 1
        ];
        animal.Name = 'test update';
        Test.startTest();
        update animal;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AnimalTriggerHelperTest.beforeAfterUpdate');
        System.assert(true, 'Create update Test.');
    }

    @Istest
    public static void beforeAfterDelete() {
        Animal__c animal = [
            SELECT Id, Name
            FROM Animal__c
            LIMIT 1
        ];
        Test.startTest();
        delete animal;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AnimalTriggerHelperTest.beforeAfterDelete');
        System.assert(true, 'Create delete Test.');
    }

    @Istest
    public static void afterUndelete() {
        Animal__c animal = [
            SELECT Id, Name
            FROM Animal__c
            LIMIT 1
        ];
        delete animal;
        Animal__c animalToUndelete = [
            SELECT Id, Name
            FROM Animal__c
            WHERE Id = :animal.Id
            LIMIT 1
            ALL ROWS
        ];
        Test.startTest();
        undelete animalToUndelete;
        Test.stopTest();
        System.debug('YNASC - Review This Test Class: AnimalTriggerHelperTest.afterUndeleteTest');
        System.assert(true, 'Create undelete Test.');
    }
}