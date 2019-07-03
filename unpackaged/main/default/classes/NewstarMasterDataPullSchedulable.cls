global class NewstarMasterDataPullSchedulable implements Schedulable, Database.AllowsCallouts {
    

    global void Execute(SchedulableContext ctx) {

        PullNewstarSalesOfficesBatch b=new PullNewstarSalesOfficesBatch();
        Database.executeBatch(b);

    }

}