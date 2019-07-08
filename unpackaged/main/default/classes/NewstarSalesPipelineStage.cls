public  class NewstarSalesPipelineStage {
    
    public String Name {get; set;}

    public Boolean IsNewstarHandoffStage {get; set;}

    public Boolean IsNewstarTriggeredStage {get; set;}

    public Boolean IsPreNewstarHandoffStage {get; set;}


    public NewstarSalesPipelineStage() {
        
        this.IsNewstarHandoffStage=false;
        this.IsNewstarTriggeredStage=false;
        this.IsPreNewstarHandoffStage=false;
    }



    //static properties representing specific pipeline stages
    public static NewstarSalesPipelineStage ProspectingStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage EngagementStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage QuoteStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage PreContractStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage LotReservationStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage PendingOfferStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage UnderContractStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage ClosedHomeStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage CancelledStage=new NewstarSalesPipelineStage();
    public static NewstarSalesPipelineStage QuoteClosedStage=new NewstarSalesPipelineStage();

    //static initializer
    static {
        
        ProspectingStage.Name='Prospecting';

        EngagementStage.IsPreNewstarHandoffStage=true;
        EngagementStage.Name='Engagement';

        QuoteStage.IsNewstarHandoffStage=true;
        QuoteStage.Name='Quote';

        PreContractStage.IsNewstarHandoffStage=true;
        PreContractStage.Name='Pre-Contract';

        LotReservationStage.IsNewstarHandoffStage=true;
        LotReservationStage.Name='Lot Reservation';

        
        PendingOfferStage.IsNewstarTriggeredStage=true;
        PendingOfferStage.Name='Pending Offer';

        UnderContractStage.IsNewstarTriggeredStage=true;
        UnderContractStage.Name='Under Contract';
        
        ClosedHomeStage.IsNewstarTriggeredStage=true;
        ClosedHomeStage.Name='Closed Home';

        CancelledStage.IsNewstarTriggeredStage=true;
        CancelledStage.Name='Cancelled';

        QuoteClosedStage.Name='Quote Closed';

    }

    
}