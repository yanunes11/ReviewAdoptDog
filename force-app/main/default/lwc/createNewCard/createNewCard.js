import { LightningElement, api } from 'lwc';
import IMAGES from "@salesforce/resourceUrl/AdoptDogLogo";

export default class CreateNewAdoptionCard extends LightningElement {
    @api iconName = "";
    @api iconAlternativeText = "";
    @api iconTitle = "";
    @api buttonLabel = "";
    @api objectApiName = "";
    @api objectFields = [];
    showFooter = false;
    // YNASC DELETE AFTER IMPLEMENTED AWS
    animalImage = IMAGES; 
    handleClick(event) {
        console.log(JSON.stringify(event));
    }
}