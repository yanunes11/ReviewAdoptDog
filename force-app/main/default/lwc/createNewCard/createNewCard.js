import { LightningElement, api } from 'lwc';

export default class CreateNewAdoptionCard extends LightningElement {
    @api iconName = "";
    @api iconAlternativeText = "";
    @api iconTitle = "";
    @api buttonLabel = "";
    @api objectApiName = "";
    @api objectFields = [];
    showFooter = false;
    handleClick(event) {
        console.log(JSON.stringify(event));
    }
}