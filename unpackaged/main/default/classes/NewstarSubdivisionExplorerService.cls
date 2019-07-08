public class NewstarSubdivisionExplorerService {
   
    /*
        Returns a list of lots available in context of the specific opportunity.EventBus

        @param opportunityId ID of the opportunity
    */
    public static NewstarSubdivisionExplorerData getExplorerDataForOpportunity(Id opportunityId) {
        
        Opportunity opp=NewstarContractInformationService.getOpportunity(opportunityId);

        NewstarSubdivisionExplorerData explorerData=new NewstarSubdivisionExplorerData();

        //only return available lots released for sale
        explorerData.lots=[
            SELECT
                Id,
                Name,
                Type__c,
                Street_Address__c,
                Released_for_Sale__c,
                Released_for_Construction__c,
                Assigned_Model__r.Name,
                Total_Price__c
            FROM
                Lot__c
            WHERE 
                Subdivision__c =: opp.Subdivision__c
                AND
                Released_For_Sale__c=true
                AND
                Status__c='Open'
        ];


        //models
        //TODO: exclude inactive models
        explorerData.models=[
            SELECT
                Id,
                Name,
                Price__c,
                Beds__c,
                Baths__c,
                Half_Baths__c,
                Garages__c,
                Floors__c,
                Sq_Ft__c
            FROM
                Model__c
            WHERE 
                Subdivision__c =: opp.Subdivision__c
               
        ];


        //special offers that either do NOT an expiry date or have not expired
        Date todayDate=System.Date.today();

        explorerData.specialOffers=[
            SELECT
                Id,
                Name,
                Description__c,
                Expiry_Date__c,
                Active__c,
                Banner_Special__c
            FROM
                Special_Offer__c
            WHERE 
                Subdivision__c =: opp.Subdivision__c
                AND
                Active__c=: true
                AND
                (
                    Expiry_Date__c =: null
                    OR
                    Expiry_Date__c >=: todayDate
                )
        ];


        List<String> stagesToReturnAsAlternates=new List<String>();

        stagesToReturnAsAlternates.add(NewstarSalesPipelineStage.ProspectingStage.Name);
        stagesToReturnAsAlternates.add(NewstarSalesPipelineStage.EngagementStage.Name);
        stagesToReturnAsAlternates.add(NewstarSalesPipelineStage.QuoteStage.Name);

        //alternate opportunities (quotes/scenarios)
        explorerData.alternateOpportunities=[
            SELECT
                Id,
                Name,
                Scenario_Name__c,
                StageName,
                Newstar_ID__c,
                Total_Sale_Amount__c
            FROM
                Opportunity
            WHERE
                AccountId=:opp.AccountId
                AND
                Lot__c=:opp.Lot__c
                AND
                Lot__c!=null
                AND
                Subdivision__c!=null
                AND
                Subdivision__c=:opp.Subdivision__c
                AND
                Id!=:opp.Id
                AND
                StageName IN : stagesToReturnAsAlternates
        ];

        explorerData.currentOpportunity=NewstarContractInformationService.getOpportunity(opportunityId);


        return explorerData;

    }


    public static SubdivisionExplorerActionResult setOpportunityLot(Id opportunityId, Id lotId) {

        SubdivisionExplorerActionResult result=new SubdivisionExplorerActionResult();

        Opportunity opp=NewstarContractInformationService.getOpportunity(opportunityId);

        Lot__c lot=getLotDetails(lotId);

        //check if lot type is spec or model
        if(isLotSpecOrModel(lot)) {

            //add a warning if the current model on the opportunity is set is NOT the one associated with the spec lot
            if(opp.Model__c!=null && opp.Model__c!=lot.Assigned_Model__c)
            {
                result.AdditionalWarningMessage='The opportunity model has been set to: ' +lot.Assigned_Model__r.Name+' based on the spec home on the selected lot: '+lot.Name;
            }
           
            //auto-set the opportunity's model to the model pre-assign to the lot
            opp.Model__c=lot.Assigned_Model__c;

        }

        opp.Lot__c=lotId;
        opp.IsAutomatedStageUpdate__c=true;

        try {
            update opp;
            result.Message='Lot '+lot.Name+' assigned to opportunity '+opp.Name;
        }
        catch(Exception e) {
            throw new NewstarContractOperationException('Error updating opportunity record: '+ e.getMessage()); 
        }

        return result;
    }



    /*
        Attempts to set the specified model on the specified opportunity.

        @param opportunityId
        @param modelId
    */
    public static SubdivisionExplorerActionResult setOpportunityModel(Id opportunityId, Id modelId) {

        SubdivisionExplorerActionResult result=new SubdivisionExplorerActionResult();

        Opportunity opp=NewstarContractInformationService.getOpportunity(opportunityId);

        Model__c model=getModelDetails(modelId);

        //important: lot may not be assigned yet
        Lot__c lot=getLotDetails(opp.Lot__c);

        //check if the lot is a spec or model and verify that in this case the model being set is the same
        if( lot!=null 
            && isLotSpecOrModel(lot)
            && lot.Assigned_Model__c!=modelId
        )
        {
            opp.Lot__c=null;
            result.AdditionalWarningMessage='The selected model: '+model.Name+' is not compatible with the opportunity\'s assigned spec lot: '+lot.Name+'. The lot has been automatically reset; please select a compatible lot again.'; 
        }
        //check if the lot is regular, but has a pre-sited model
        else if(
            lot!=null 
            && lot.Assigned_Model__c!=null
            && lot.Assigned_Model__c!=modelId
            ){
            opp.Lot__c=null;
            result.AdditionalWarningMessage='The selected model: '+model.Name+' is not compatible with the opportunity\'s assigned regular lot: '+lot.Name+' which specifies a pre-sited model. The lot has been automatically reset; please select a compatible lot again.'; 
        }

        //assign the model
        opp.Model__c=modelId;

        //ensure that the processing pipeline seems this an automated update
        opp.IsAutomatedStageUpdate__c=true;

        try {
            update opp;
            result.Message='Model '+model.Name+' assigned to opportunity '+opp.Name;
        }
        catch(Exception e) {
            throw new NewstarContractOperationException('Error updating opportunity record: '+ e.getMessage()); 
        }

        return result;
    }


    private static Lot__c getLotDetails(Id lotId) {

        List<Lot__c> lots=[
            SELECT
                Id,
                Name,
                Type__c,
                Assigned_Model__c,
                Assigned_Model__r.Name
            FROM
                Lot__c
            WHERE
                Id =: lotId
            LIMIT 1
        ];

        if(lots.size()==1){
            return lots[0];
        }

        return null;
    }


    private static Model__c getModelDetails(Id modelId) {

        List<Model__c> models=[
            SELECT
                Id,
                Name
            FROM
                Model__c
            WHERE
                Id =: modelId
            LIMIT 1
        ];

        if(models.size()==1){
            return models[0];
        }

        return null;
    }


    private static Boolean isLotSpecOrModel(Lot__c lot) {
        return lot.Type__c=='Spec' || lot.Type__c=='Model';
    }

}