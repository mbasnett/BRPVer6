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
 * Represents a generic API operation result used to indicate.
 */
public class NewstarOperationResult {
    /**
     * ID of the entity affected by the API operation.
     * @return entityId
     */
    public Integer entityId { get; set; }

   public static NewstarOperationResult getExample() {
        NewstarOperationResult operationResult = new NewstarOperationResult();
          operationResult.entityId = 0;
        return operationResult;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarOperationResult) {           
            NewstarOperationResult operationResult = (NewstarOperationResult) obj;
            return this.entityId == operationResult.entityId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (entityId == null ? 0 : System.hashCode(entityId));
        return hashCode;
    }
}