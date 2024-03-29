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
 * Represents a model (floor plan) that a customer can buy in NEWSTAR Sales.
 */
public class NewstarModel {
    /**
     * Unique ID of the model.
     * @return id
     */
    public Integer id { get; set; }

    /**
     * Actual name of the model.
     * @return name
     */
    public String name { get; set; }

    /**
     * Elevation of the model.
     * @return elevation
     */
    public String elevation { get; set; }

    /**
     * NEWSTAR back-office (purchasing) code for the model.
     * @return code
     */
    public String code { get; set; }

    /**
     * Flag indicating if the model is active (available for sale).
     * @return isActive
     */
    public Boolean isActive { get; set; }

    /**
     * Square Footage of the model.
     * @return squareFootage
     */
    public Integer squareFootage { get; set; }

    /**
     * No Of Bedrooms of the model.
     * @return bedrooms
     */
    public Integer bedrooms { get; set; }

    /**
     * No of Full Baths of the model.
     * @return fullBaths
     */
    public Integer fullBaths { get; set; }

    /**
     * No of Half Baths of the model.
     * @return halfBaths
     */
    public Integer halfBaths { get; set; }

    /**
     * Garage Capacity of the model.
     * @return garageCapacity
     */
    public Integer garageCapacity { get; set; }

    /**
     * Base Model Price of the model.
     * @return baseModelPrice
     */
    public Double baseModelPrice { get; set; }

   public static NewstarModel getExample() {
        NewstarModel model = new NewstarModel();
          model.id = 0;
          model.name = '';
          model.elevation = '';
          model.code = '';
          model.isActive = true;
          model.squareFootage = 0;
          model.bedrooms = 0;
          model.fullBaths = 0;
          model.halfBaths = 0;
          model.garageCapacity = 0;
          model.baseModelPrice = 1.3579;
        return model;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarModel) {           
            NewstarModel model = (NewstarModel) obj;
            return this.id == model.id
                && this.name == model.name
                && this.elevation == model.elevation
                && this.code == model.code
                && this.isActive == model.isActive
                && this.squareFootage == model.squareFootage
                && this.bedrooms == model.bedrooms
                && this.fullBaths == model.fullBaths
                && this.halfBaths == model.halfBaths
                && this.garageCapacity == model.garageCapacity
                && this.baseModelPrice == model.baseModelPrice;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (name == null ? 0 : System.hashCode(name));
        hashCode = (17 * hashCode) + (elevation == null ? 0 : System.hashCode(elevation));
        hashCode = (17 * hashCode) + (code == null ? 0 : System.hashCode(code));
        hashCode = (17 * hashCode) + (isActive == null ? 0 : System.hashCode(isActive));
        hashCode = (17 * hashCode) + (squareFootage == null ? 0 : System.hashCode(squareFootage));
        hashCode = (17 * hashCode) + (bedrooms == null ? 0 : System.hashCode(bedrooms));
        hashCode = (17 * hashCode) + (fullBaths == null ? 0 : System.hashCode(fullBaths));
        hashCode = (17 * hashCode) + (halfBaths == null ? 0 : System.hashCode(halfBaths));
        hashCode = (17 * hashCode) + (garageCapacity == null ? 0 : System.hashCode(garageCapacity));
        hashCode = (17 * hashCode) + (baseModelPrice == null ? 0 : System.hashCode(baseModelPrice));
        return hashCode;
    }
}