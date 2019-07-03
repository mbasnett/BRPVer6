public class NewstarDealFinancialInfo {
    
    public Decimal BaseModelPrice {get; set;}
    public Decimal LotPrice {get; set;}
    public Decimal LotPremium {get; set;}
    public Decimal TotalOptionsAmount {get; set;}
    public Decimal TotalDiscountAmount {get; set;}
    public Decimal TotalTaxAmount {get; set;}
    public Decimal TotalTaxRebateAmount {get; set;}
    public Decimal TotalActualSaleAmount {get; set;}
    
    
    public NewstarDealFinancialInfo() {
        this.BaseModelPrice=0;
        this.LotPrice=0;
        this.LotPremium=0;
        this.TotalOptionsAmount=0;
        this.TotalDiscountAmount=0;
        this.TotalTaxAmount=0;
        this.TotalTaxRebateAmount=0;
        this.TotalActualSaleAmount=0;
    }
}