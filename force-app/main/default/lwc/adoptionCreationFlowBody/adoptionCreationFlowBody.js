import { LightningElement, api } from 'lwc';

export default class AdoptionCreationFlowBody extends LightningElement {

    // YNASC - DELETE BECAUSE IT WILL BE BROGHT FROM DB - START
    @api animalObjectFields = [
        {id: 'a00aj000006C4GMAA0', fieldName: "Name", value: 'Linim'},
        {id: 'a00aj000006C4GMAA0', fieldName: "Adopter Name", value: 'Amannda'},
        {id: 'a00aj000006C4GMAA0', fieldName: "Age(Years)", value: 10},
        {id: 'a00aj000006C4GMAA0', fieldName: "Weight(Kg)", value: 3.5}
    ];
    // YNASC - DELETE BECAUSE IT WILL BE BROGHT FROM DB - END
}