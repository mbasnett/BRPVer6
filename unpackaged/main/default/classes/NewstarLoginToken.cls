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
 * Represents a login token response issued upon successful authentication against the API.
 */
public class NewstarLoginToken {
    /**
     * Encrypted value of the token.
     * @return value
     */
    public String value { get; set; }

   public static NewstarLoginToken getExample() {
        NewstarLoginToken loginToken = new NewstarLoginToken();
          loginToken.value = '';
        return loginToken;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarLoginToken) {           
            NewstarLoginToken loginToken = (NewstarLoginToken) obj;
            return this.value == loginToken.value;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (value == null ? 0 : System.hashCode(value));
        return hashCode;
    }
}