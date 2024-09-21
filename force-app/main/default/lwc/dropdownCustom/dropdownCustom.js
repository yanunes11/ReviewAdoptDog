import { LightningElement, api, track } from 'lwc';

export default class DropdownCustom extends LightningElement {
    isLoading = true; 
    error;
    @api inputLabel = '';
    @api type = 'text';

    @track autoCompleteOptions = []; // filtered list of options based on search string
    @api objectMap = {}; // for instance: [{"id":"AdoptionProcess","value":"Adoption Process"},{"id":"Adopted","value":"Adopted"}]

    @track selectedFieldAPIName = '';
    @api selectedRecordId = '';
    @api isObjectSelectionRO = false;
    @api isRequired = false;
    @api placeHolder = 'Set placeHolder to change this message' //placeholder shown in the input before choosing a value on dropdown
    inputValue = '';

    connectedCallback() {
        this.isLoading = false;
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
        return this.selectedFieldAPIName;
    }

    get isNotSelectedFieldNameReference() {
        return !this.selectedFieldNameReference;
    }

    /**
     * Handlers
     */

    // show the the complete record list when click on the input box
    handleInputClick(event) {
        this.autoCompleteOptions = this.objectMap;
        this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.add('slds-is-open');
        this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.focus();
        const selectedEvent = new CustomEvent('applyclasscustomheight', { detail: {customclass: 'custom-height--inherit'} });
        this.dispatchEvent(selectedEvent);
    }

    handleInputChange(event) {
        this.inputClear(event); //if record has been cleared, send event to parent.
        this.selectedFieldAPIName = ''; // resets the selected object whenever the search box is changed
        const inputVal = event.target.value; // gets search input value
        this.inputValue = inputVal;
        // filters in real time the list received from the record list
        this.autoCompleteOptions = this.objectMap;
        // make visible the combobox, expanding it.
        if (this.autoCompleteOptions.length && inputVal) {
            this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.add('slds-is-open');
            this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.focus();
        }
    }

    //if record has been cleared, send event to parent.
    inputClear(event) {
        if (JSON.stringify(event.currentTarget.dataset) === '{}') {
            const selectedEvent = new CustomEvent('recordunselected', { detail: {unselected: true, recordid: this.selectedRecordId} });
            this.dispatchEvent(selectedEvent);
        }
    }

    // Trickiest detail of this LWC.
    // the setTimeout is a workaround required to ensure the user click selects the record.
    handleInputOnBlur(event) {
        setTimeout(() => {
            this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.remove('slds-is-open');
            const selectedEvent = new CustomEvent('removeclasscustomheight', { detail: {customclass: 'custom-height--inherit'} });
            this.dispatchEvent(selectedEvent);
        }, 200);
    }

    // Stores the selected record and hides the combobox
    handleOptionClick(event) {
        this.selectedFieldAPIName = event.currentTarget?.dataset?.value;//get the name of the chosen record
        this.selectedRecordId = event.currentTarget?.dataset?.id;//get the Id of the chosen record
        this.template.querySelector('.slds-combobox.slds-dropdown-trigger.slds-dropdown-trigger_click')?.classList.remove('slds-is-open');
        // throw custom event to be caught by parent LWC
        const selectedEvent = new CustomEvent('recordselected', { detail: this.selectedRecordId });
        this.dispatchEvent(selectedEvent);
    }
}