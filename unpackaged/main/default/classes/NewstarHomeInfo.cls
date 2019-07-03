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
 * Represents a home object with the information about a particular sale and contract details.
 */
public class NewstarHomeInfo {
    /**
     * Unique ID of the lot reservation ID used to create the contract/sell the home.
     * @return id
     */
    public Integer id { get; set; }

    /**
     * Lot number associated with the contract.
     * @return lotNumber
     */
    public String lotNumber { get; set; }

    /**
     * Full name (first, last) of the sales staff member that approved the contract.
     * @return approvedByUserFullName
     */
    public String approvedByUserFullName { get; private set; }

    /**
     * Full name (first, last) of the builder assigned to manage construction on the lot.
     * @return builderFullName
     */
    public String builderFullName { get; set; }

    /**
     * Total base model amount, including the associated lot price and premium, as applicable.
     * @return totalBaseModelAmount
     */
    public Double totalBaseModelAmount { get; set; }

    /**
     * Total amount of all non-cancelled options approved on the deal.
     * @return totalOptionsAmount
     */
    public Double totalOptionsAmount { get; set; }

    /**
     * Total tax-out (before tax) amount of the deal.
     * @return totalTaxOutSaleAmount
     */
    public Double totalTaxOutSaleAmount { get; set; }

    /**
     * Total tax amount applicable to the deal.
     * @return totalTaxAmount
     */
    public Double totalTaxAmount { get; set; }

    /**
     * Total tax rebate amount applicable to the deal.
     * @return totalTaxRebateAmount
     */
    public Double totalTaxRebateAmount { get; set; }

    /**
     * Total tax-in (after tax) amount of the deal.
     * @return totalTaxInAmount
     */
    public Double totalTaxInAmount { get; set; }

   public static NewstarHomeInfo getExample() {
        NewstarHomeInfo homeInfo = new NewstarHomeInfo();
          homeInfo.id = 0;
          homeInfo.lotNumber = '';
          homeInfo.approvedByUserFullName = '';
          homeInfo.builderFullName = '';
          homeInfo.totalBaseModelAmount = 1.3579;
          homeInfo.totalOptionsAmount = 1.3579;
          homeInfo.totalTaxOutSaleAmount = 1.3579;
          homeInfo.totalTaxAmount = 1.3579;
          homeInfo.totalTaxRebateAmount = 1.3579;
          homeInfo.totalTaxInAmount = 1.3579;
        return homeInfo;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof NewstarHomeInfo) {           
            NewstarHomeInfo homeInfo = (NewstarHomeInfo) obj;
            return this.id == homeInfo.id
                && this.lotNumber == homeInfo.lotNumber
                && this.approvedByUserFullName == homeInfo.approvedByUserFullName
                && this.builderFullName == homeInfo.builderFullName
                && this.totalBaseModelAmount == homeInfo.totalBaseModelAmount
                && this.totalOptionsAmount == homeInfo.totalOptionsAmount
                && this.totalTaxOutSaleAmount == homeInfo.totalTaxOutSaleAmount
                && this.totalTaxAmount == homeInfo.totalTaxAmount
                && this.totalTaxRebateAmount == homeInfo.totalTaxRebateAmount
                && this.totalTaxInAmount == homeInfo.totalTaxInAmount;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (lotNumber == null ? 0 : System.hashCode(lotNumber));
        hashCode = (17 * hashCode) + (approvedByUserFullName == null ? 0 : System.hashCode(approvedByUserFullName));
        hashCode = (17 * hashCode) + (builderFullName == null ? 0 : System.hashCode(builderFullName));
        hashCode = (17 * hashCode) + (totalBaseModelAmount == null ? 0 : System.hashCode(totalBaseModelAmount));
        hashCode = (17 * hashCode) + (totalOptionsAmount == null ? 0 : System.hashCode(totalOptionsAmount));
        hashCode = (17 * hashCode) + (totalTaxOutSaleAmount == null ? 0 : System.hashCode(totalTaxOutSaleAmount));
        hashCode = (17 * hashCode) + (totalTaxAmount == null ? 0 : System.hashCode(totalTaxAmount));
        hashCode = (17 * hashCode) + (totalTaxRebateAmount == null ? 0 : System.hashCode(totalTaxRebateAmount));
        hashCode = (17 * hashCode) + (totalTaxInAmount == null ? 0 : System.hashCode(totalTaxInAmount));
        return hashCode;
    }
}