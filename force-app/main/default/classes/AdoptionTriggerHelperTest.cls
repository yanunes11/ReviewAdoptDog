@IsTest
public with sharing class AdoptionTriggerHelperTest {

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

    @IsTest
    public static void checkUpdateAnimalHasBeenAdoptedTest() {

        //Instanciate new objects
        Adopter__c adopter2 = new Adopter__c(Name = 'Andre');
        insert adopter2;
        Animal__c animal2 = new Animal__c(Name = 'Toin');
        insert animal2;
        Adoption__c adoption2 = new Adoption__c(Animal__c = animal2.Id, Adopter__c = adopter2.Id, Adoption_Stage__c = 'Adopted');
        insert adoption2;

        //Query for Adoption Animals with Adoption_Stage__c = Adopted
        Adoption__c adoption = [
            SELECT Id, Animal__c, Adopter__c, Adoption_Stage__c
            FROM Adoption__c
            WHERE Adoption_Stage__c = 'Adopted'
            LIMIT 1
        ];

        adoption2.Animal__c = adoption.Animal__c;

        Boolean hasAddError = false;

        Test.startTest();
        try {
            update adoption2;
        } catch (Exception e) {
            System.debug(e.getMessage());
            hasAddError =  e.getMessage().contains('This animal has been adopted! Sorry!') ? true : false;
        }
        Test.stopTest();
        System.assertEquals(hasAddError, true, 'Notification not displayed upon updating an adoption for an animal that has already been adopted. This message should be shown: \'This animal has been adopted! Sorry!\' ');
    }
}