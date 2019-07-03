trigger OpportunityInfoSetTrigger on Opportunity (before insert, before update) {

    for(Opportunity opp: Trigger.new){

        Opportunity prevOpp = null;
        
        if(!Trigger.isInsert) {
            prevOpp=Trigger.oldMap.get(opp.Id);
        }
         
         //get deal context
        NewstarDealContext dealContext=NewstarOpporunityInfoService.getDealContext(opp);
     
      //set the opportunity name using marketing community
        NewstarOpporunityInfoService.setOpportunityNameAtMarketingCommunityLevel(opp, dealContext);

        //if this lead is  just being created from a lead conversion...
        if(opp.Converted_From_Lead__c && Trigger.isInsert)
        {

            //initialize the marketing community's default sales process
            NewstarOpporunityInfoService.setOpportunitySalesProcess(opp, dealContext);

            //skip further processing
            continue;
        }


        //set the opportunity's name using subdivision-level information, if available
        NewstarOpporunityInfoService.setOpportunityNameAtSubdivisionLevel(opp, dealContext);

        //if the opportunity is still in pure marketing stage on the pre-handoff stage
        //update name and financials
        String stageToCheck=opp.StageName;
        if(stageToCheck==null && prevOpp!=null) {
            stageToCheck=prevOpp.StageName;
        }

        if(
            NewstarSalesPipelineService.IsPureMarketingStage(stageToCheck)
            || NewstarSalesPipelineService.IsPreNewstarHandoffStage(stageToCheck)
            ){

            //set opportunity's ESTIMATED financial details based on model/lot selections
            NewstarOpporunityInfoService.setOpportunityAmountsFromDealContext(opp, dealContext);
        }

        
    }

   
}