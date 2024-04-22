public with sharing class TriggerDataDTO {
    private List<SObject> newValues;
    private List<SObject> oldValues;
    private Map<Id, SObject> mapNew;
    private Map<Id, SObject> mapOld;
    private String operationType;

    // Private constructor
    private TriggerDataDTO(Builder builder) {
        this.newValues = builder.newValues;
        this.oldValues = builder.oldValues;
        this.mapNew = builder.mapNew;
        this.mapOld = builder.mapOld;
        this.operationType = builder.operationType;
    }

    // Getters for each field
    public List<SObject> getNewValues() {
        return newValues;
    }

    public List<SObject> getOldValues() {
        return oldValues;
    }

    public Map<Id, SObject> getMapNew() {
        return mapNew;
    }

    public Map<Id, SObject> getMapOld() {
        return mapOld;
    }

    public String getOperationType() {
        return operationType;
    }

    // Builder class
    public class Builder {
        private List<SObject> newValues;
        private List<SObject> oldValues;
        private Map<Id, SObject> mapNew;
        private Map<Id, SObject> mapOld;
        private String operationType;

        public Builder setNewValues(List<SObject> newValues) {
            this.newValues = newValues;
            return this;
        }

        public Builder setOldValues(List<SObject> oldValues) {
            this.oldValues = oldValues;
            return this;
        }

        public Builder setMapNew(Map<Id, SObject> mapNew) {
            this.mapNew = mapNew;
            return this;
        }

        public Builder setMapOld(Map<Id, SObject> mapOld) {
            this.mapOld = mapOld;
            return this;
        }

        public Builder setOperationType(String operationType) {
            this.operationType = operationType;
            return this;
        }

        public TriggerDataDTO build() {
            return new TriggerDataDTO(this);
        }
    }
}
