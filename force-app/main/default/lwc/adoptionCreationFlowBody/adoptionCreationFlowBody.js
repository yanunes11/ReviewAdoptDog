import { LightningElement, api } from 'lwc';
import animalInformation from '@salesforce/apex/AnimalQueries.getAnimalInformationById';

export default class AdoptionCreationFlowBody extends LightningElement {
    animalId = 'a00aj000006C4GMAA0';
    @api animal;
    animalObjectFields = [];
    error;
    connectedCallback() {
        this.getAnimalInformation(this.animalId);
    }

    getAnimalInformation(animalId) {
        let animal = [];
        animalInformation({animalId: animalId})
        .then((result) => {
            for (let key in result) {
                if (key !== 'Id') {
                    let cleanKey = key.replace("__c", "").replace("_", " ");
                    let animaObject = {'fieldName': cleanKey, 'value': result[key]};
                    animal.push(animaObject);
                }
            }
            this.animalObjectFields = animal;
            console.log('YNASC here: '+JSON.stringify(this.animalObjectFields));
        })
        .catch((error) => {
            console.log('YNASC error: '+JSON.stringify(error));
        })
        console.log('YNASC final: '+JSON.stringify(this.animalObjectFields));
    }

}