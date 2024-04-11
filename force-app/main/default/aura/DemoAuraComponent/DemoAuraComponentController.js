({
    openModal : function(component, event, helper) {
        component.set("v.isModalHidden", false);
    },

    onConfirm: function(component, event, helper) {
        console.log('Will be called when confirm button is clicked on modal');
        component.set("v.isModalHidden", true);
    },

    onCancel: function(component, event, helper) {
        console.log('Will be called when cancel button is clicked on modal');
        component.set("v.isModalHidden", true);
    }
})