public with sharing class AdoptionServices {
    @AuraEnabled (cacheable = false)
    public static Id createAdoption(Map<String, String> params) {
        Adoption__c newAdoption = new Adoption__c(
            Animal__c = params.get('animalId'),
            Adopter__c = params.get('adopterId'),
            Adoption_Stage__c = params.get('adoptionStage')
        );
        if (Schema.sObjectType.Adoption__c.isCreateable()) {
            try {
                insert newAdoption;
            } catch (DmlException e) {
                System.debug('Error Message'+e.getMessage());
            }
        } else {
            throw new DmlException('No permissions to update.');
        }
        return newAdoption.Id;
    }
}