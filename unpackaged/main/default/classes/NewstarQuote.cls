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
 * Represents a customer quote-type (pricing scenario) in NEWSTAR Sales.
 */
public class NewstarQuote {
    /**
     * Unique ID of the Quote in NEWSTAR Sales.
     * @return id
     */
    public Integer id { get; set; }

    /**
     * Get customer
     * @return customer
     */
    public NewstarCustomer customer { get; set; }

    /**
     * Cobuyers for whom the quote is created for.
     * @return coBuyers
     */
    public List<NewstarCoBuyer> coBuyers { get; set; }

    /**
     * ID of the subdivision to create the quote in.
     * @return subdivisionId
     */
    public Integer subdivisionId { get; set; }

    /**
     * ID of the model to pre-select on the reserved lot.
     * @return modelId
     */
    public Integer modelId { get; set; }

    /**
     * ID of the lot to reserve in the specified subdivision.
     * @return lotId
     */
    public Integer lotId { get; set; }

    /**
     * Orientation of the model on the lot (swing).
     */
    public enum SwingEnum {
        UNSET,
        LEFT,
        RIGHT
    }

    /**
     * Orientation of the model on the lot (swing).
     * @return swing
     */
    public SwingEnum swing { get; set; }

    /**
     * ID of the NEWSTAR Sales user to associate the customer (and quote) with.
     * @return salesAgentId
     */
    public Integer salesAgentId { get; set; }

    /**
     * List of contigency conditions associated with quote.
     * @return contingencies
     */
    public List<NewstarContingency> contingencies { get; set; }

    /**
     * ID of the real estate agent optionally associated with this deal.
     * @return realEstateAgentId
     */
    public Integer realEstateAgentId { get; set; }

    /**
     * Specifies a user-friendly name of the pricing scenario that serves as an alias for the quote.
     * @return scenarioName
     */
    public String scenarioName { get; set; }

    /**
     * ID of the entity in Salesforce.
     * @return externalId
     */
    public String externalId { get; set; }

    public NewstarQuote() {
        coBuyers = new List<NewstarCoBuyer>();
        contingencies = new List<NewstarContingency>();
    }

   public static NewstarQuote getExample() {
        NewstarQuote quote = new NewstarQuote();
          quote.id = 0;
          quote.customer = NewstarCustomer.getExample();
          quote.coBuyers = new List<NewstarCoBuyer>{NewstarCoBuyer.getExample()};
          quote.subdivisionId = 0;
          quote.modelId = 0;
          quote.lotId = 0;
          quote.swing = SwingEnum.UNSET;
          quote.salesAgentId = 0;
          quote.contingencies = new List<NewstarContingency>{NewstarContingency.getExample()};
          quote.realEstateAgentId = 0;
          quote.scenarioName = '';
          quote.externalId = '';
        return quote;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarQuote) {           
            NewstarQuote quote = (NewstarQuote) obj;
            return this.id == quote.id
                && this.customer == quote.customer
                && this.coBuyers == quote.coBuyers
                && this.subdivisionId == quote.subdivisionId
                && this.modelId == quote.modelId
                && this.lotId == quote.lotId
                && this.swing == quote.swing
                && this.salesAgentId == quote.salesAgentId
                && this.contingencies == quote.contingencies
                && this.realEstateAgentId == quote.realEstateAgentId
                && this.scenarioName == quote.scenarioName
                && this.externalId == quote.externalId;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (customer == null ? 0 : System.hashCode(customer));
        hashCode = (17 * hashCode) + (coBuyers == null ? 0 : System.hashCode(coBuyers));
        hashCode = (17 * hashCode) + (subdivisionId == null ? 0 : System.hashCode(subdivisionId));
        hashCode = (17 * hashCode) + (modelId == null ? 0 : System.hashCode(modelId));
        hashCode = (17 * hashCode) + (lotId == null ? 0 : System.hashCode(lotId));
        hashCode = (17 * hashCode) + (swing == null ? 0 : System.hashCode(swing));
        hashCode = (17 * hashCode) + (salesAgentId == null ? 0 : System.hashCode(salesAgentId));
        hashCode = (17 * hashCode) + (contingencies == null ? 0 : System.hashCode(contingencies));
        hashCode = (17 * hashCode) + (realEstateAgentId == null ? 0 : System.hashCode(realEstateAgentId));
        hashCode = (17 * hashCode) + (scenarioName == null ? 0 : System.hashCode(scenarioName));
        hashCode = (17 * hashCode) + (externalId == null ? 0 : System.hashCode(externalId));
        return hashCode;
    }
}