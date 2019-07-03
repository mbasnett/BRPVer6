/*
 * Constellation SFDC Integration API
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * OpenAPI spec version: v1
 * 
 *
 * NOTE: This class is auto generated by the OAS code generator program.
 * https://github.com/OAS-api/OAS-codegen.git
 * Do not edit the class manually.
 */

/**
 * NewstarContingency
 */
public class NewstarContingency {
    /**
     * Unique ID of the contigency record in NEWSTAR Sales.
     * @return id
     */
    public Integer id { get; set; }

    /**
     * ID of the contigency record type (defined by the builder).
     * @return typeId
     */
    public Integer typeId { get; set; }

    /**
     * Contingency Expiry Date.
     * @return expiryDate
     */
    public Datetime expiryDate { get; set; }

    /**
     * Contingency Met Date.
     * @return metDate
     */
    public Datetime metDate { get; set; }

    /**
     * Contingency Notes.
     * @return notes
     */
    public String notes { get; set; }

    /**
     * ID of the entity in Salesforce.
     * @return externalId
     */
    public String externalId { get; set; }

   public static NewstarContingency getExample() {
        NewstarContingency contingency = new NewstarContingency();
          contingency.id = 0;
          contingency.typeId = 0;
          contingency.expiryDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
          contingency.metDate = Datetime.newInstanceGmt(2000, 1, 23, 4, 56, 7);
          contingency.notes = '';
          contingency.externalId = '';
        return contingency;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarContingency) {           
            NewstarContingency contingency = (NewstarContingency) obj;
            return this.id == contingency.id
                && this.typeId == contingency.typeId
                && this.expiryDate == contingency.expiryDate
                && this.metDate == contingency.metDate
                && this.notes == contingency.notes
                && this.externalId == contingency.externalId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (typeId == null ? 0 : System.hashCode(typeId));
        hashCode = (17 * hashCode) + (expiryDate == null ? 0 : System.hashCode(expiryDate));
        hashCode = (17 * hashCode) + (metDate == null ? 0 : System.hashCode(metDate));
        hashCode = (17 * hashCode) + (notes == null ? 0 : System.hashCode(notes));
        hashCode = (17 * hashCode) + (externalId == null ? 0 : System.hashCode(externalId));
        return hashCode;
    }
}