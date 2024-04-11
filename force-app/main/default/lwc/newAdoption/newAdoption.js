import { LightningElement, api } from 'lwc';

export default class NewAdoption extends LightningElement {

    @api content;

    @api objectFields = [
        {field: "Animal__c"},
        {field: "Adopter__c"},
        {field: "Adoption_Stage__c"}
    ];

    handleOkay() {
        this.close('okay');
    }
}