public with sharing class AdoptionServices {
    @AuraEnabled (cacheable = True)
    public static void createAdoption(Map<String, String> params) {
        
        Adoption__c newAdoption = new Adoption__c(
            Animal__c = params.get('animalId'),
            Adopter__c = params.get('adopterId'),
            Adoption_Stage__c = params.get('adoptionStage')
        );
            
        try {
            if (Schema.sObjectType.Adoption__c.isCreateable()) {
                insert newAdoption;
            }
        } catch (DmlException e) {
            System.debug('Error Message'+e.getMessage());
        }
    }
}