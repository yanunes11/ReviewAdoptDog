import { LightningElement, api, track } from 'lwc';
import animalListInformation from '@salesforce/apex/AnimalQueries.getAvailableAnimalList';

export default class InputRecordList extends LightningElement {
    isLoading = true; 
    @api inputLabel = 'inputLabel variable';
    error;

    @track autoCompleteOptions = []; // filtered list of options based on search string
    @track objectsList = []; // complete list of objects returned by the apex method
    @track objectsMap = {}; // useful to get a map

    @api selectedFieldAPIName = '';
    @api isObjectSelectionRO = false;
    @api isRequired = false;
    inputValue = '';

    connectedCallback() {
        this.getAnimalList();
    }

    async getAnimalList() {
        try {
            this.isLoading = false;
            let objectsMapAux = [];
            objectsMapAux = await animalListInformation();
            this.objectsMap = JSON.parse(JSON.stringify(objectsMapAux));
            this.objectsList = Object.values(this.objectsMap);
        } catch (error) {
            this.error = error;
        }
    }

    @api validate() {
        // to be called from parent LWC if for example the search box is present
        // on a form and needs to be validated before submission.
        this.template.querySelector('lightning-input').reportValidity();
    }

    /**
     * Getter and setters
     */
    get selectedFieldNameReference() {
        return this.objectsMap[this.selectedFieldAPIName]?.name;
    }

    /**
     * Handlers
     */

    handleClick(event) {
        this.autoCompleteOptions = this.objectsList.filter(item => item.name.toLowerCase().includes(this.inputValue.toLowerCase()));
        this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.add('slds-is-open');
        this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.focus();
    }

    handleInputChange(event) {
        this.selectedFieldAPIName = ''; // resets the selected object whenever the search box is changed
        const inputVal = event.target.value; // gets search input value
        this.inputValue = inputVal;
        // filters in real time the list received from the wired Apex method
        this.autoCompleteOptions = this.objectsList.filter(item => item.name.toLowerCase().includes(inputVal.toLowerCase()));
        // makes visible the combobox, expanding it.
        if (this.autoCompleteOptions.length && inputVal) {
            this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.add('slds-is-open');
            this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.focus();
        }
    }

    handleOnBlur(event) {
        // Trickiest detail of this LWC.
        // the setTimeout is a workaround required to ensure the user click selects the record.
        setTimeout(() => {
            if (!this.selectedFieldAPIName) {
                this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.remove('slds-is-open');
            }
        }, 300);
    }

    handleOptionClick(event) {
        // Stores the selected objected and hides the combobox
        this.selectedFieldAPIName = event.currentTarget?.dataset?.name;
        this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.remove('slds-is-open');
        // throw custom event to be caught by parent LWC
        const selectedEvent = new CustomEvent('objectselected', { detail: this.selectedFieldAPIName });
        this.dispatchEvent(selectedEvent);
    }
}