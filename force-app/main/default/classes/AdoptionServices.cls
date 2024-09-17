public with sharing class AdoptionServices {

    // Create an adoption only if the animal does not already have an adopter.
    @AuraEnabled (cacheable = false)
    public static Id createAdoption(Map<String, String> params) {
        Adoption__c newAdoption = new Adoption__c(
            Animal__c = params.get('animalId'),
            Adopter__c = params.get('adopterId'),
            Adoption_Stage__c = params.get('adoptionStage')
        );
        Animal__c animal = [
            SELECT Adopter__c
            FROM Animal__c
            WHERE Id = :newAdoption.Animal__c
            WITH SYSTEM_MODE
        ];
        if (Schema.sObjectType.Adoption__c.isCreateable() && animal.Adopter__c == null) {
            try {
                insert newAdoption;
            } catch (DmlException e) {
                System.debug('Error Message: '+e.getMessage());
                throw new DmlException('Error Message: '+e.getMessage());
            }
        } else {
            throw new DmlException('Permission denied to update, or the animal already has an adopter.');
        }
        return newAdoption.Id;
    }
}