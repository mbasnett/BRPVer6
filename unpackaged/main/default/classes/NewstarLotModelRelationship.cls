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
 * NewstarLotModelRelationship
 */
public class NewstarLotModelRelationship {
    /**
     * Internal unique ID of the relationship.
     * @return id
     */
    public Integer id { get; set; }

    /**
     * ID of the model available for construction on the lot.
     * @return modelId
     */
    public Integer modelId { get; set; }

    /**
     * Flag indicating if the relationship is active.
     * @return isActive
     */
    public Boolean isActive { get; set; }

   public static NewstarLotModelRelationship getExample() {
        NewstarLotModelRelationship lotModelRelationship = new NewstarLotModelRelationship();
          lotModelRelationship.id = 0;
          lotModelRelationship.modelId = 0;
          lotModelRelationship.isActive = true;
        return lotModelRelationship;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarLotModelRelationship) {           
            NewstarLotModelRelationship lotModelRelationship = (NewstarLotModelRelationship) obj;
            return this.id == lotModelRelationship.id
                && this.modelId == lotModelRelationship.modelId
                && this.isActive == lotModelRelationship.isActive;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (modelId == null ? 0 : System.hashCode(modelId));
        hashCode = (17 * hashCode) + (isActive == null ? 0 : System.hashCode(isActive));
        return hashCode;
    }
}