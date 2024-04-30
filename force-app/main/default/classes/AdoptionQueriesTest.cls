@IsTest
public with sharing class AdoptionQueriesTest {
    
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

    @isTest
    public static void retrieveAdoptionStageInfoTest() {

        Test.startTest();
        Map<String, String> adoptionStagesMap = AdoptionQueries.retrieveAdoptionStageInfo();
        Test.stopTest();

        schema.DescribeFieldResult adoptionStages = schema.SObjectType.Adoption__c.fields.Adoption_Stage__c.getsObjectField().getDescribe();
        Map<String, String> adoptionStagesMapToCompare = new Map<String, String>();
        for (PicklistEntry ent : adoptionStages.getPicklistValues()) {
            if (ent.isActive()) {
                if (ent.getValue() == 'Adopted' || ent.getValue() == 'Adoption Process' || ent.getValue() == 'Back To Shelter') {
                    adoptionStagesMapToCompare.put(ent.getLabel(), ent.getValue());
                }
            }
        }
        System.assertEquals(adoptionStagesMapToCompare.get('Adopted'), adoptionStagesMap.get('Adopted'), 'It\'s not retrieving the Adopter option');
        System.assertEquals(adoptionStagesMapToCompare.get('Adoption Process'), adoptionStagesMap.get('Adoption Process'), 'It\'s not retrieving the Adoption Process option');
        System.assertEquals(adoptionStagesMapToCompare.get('Back To Shelter'), adoptionStagesMap.get('Back To Shelter'), 'It\'s not retrieving the Back To Shelter option');
        System.assertEquals(adoptionStagesMapToCompare.size(), adoptionStagesMap.size(), 'The number of options varies. One or more options have been added or deleted. Please ensure they are included in the tests.');
    }
}