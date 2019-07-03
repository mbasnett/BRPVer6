public class TestDataFactory {
    

    public static Opportunity generateContractOperationsReadyOpportunity() {

        Opportunity opp=new Opportunity();


        Account customerAccount=generateCustomerAccount();
        

        insert customerAccount;
        insert opp;

        return opp;

    }

    


    private static Account generateCustomerAccount() {

        Account customerAccount=new Account();
        customerAccount.FirstName='Test_F_'+String.valueOf(System.Date.today());
        customerAccount.LastName='Test_L_'+String.valueOf(System.Date.today());

        return customerAccount;
        
    }

}