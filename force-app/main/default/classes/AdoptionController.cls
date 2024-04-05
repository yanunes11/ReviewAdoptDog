public with sharing class AdoptionController {
    @AuraEnabled
    public static void methodName(){
        try {
            System.debug('Test @AuraEnabled');
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}