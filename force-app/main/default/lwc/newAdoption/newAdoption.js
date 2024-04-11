import { LightningElement, api } from 'lwc';
import LightningModal from 'lightning/modal';

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