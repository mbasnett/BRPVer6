public with sharing class CachedCollections {

    private static boolean run = true;
    public static boolean runOnce(){
    System.debug('run variable: ' + run);
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }
    }

    public static List <Marketing_Community__c> myCommunityList {
        get {
            if(myCommunityList == null){
                myCommunityList = [SELECT Name, Id,Assigned_Queue__c,sales_office__c From Marketing_Community__c];
            }
        return myCommunityList;
        }
    set;
    }
    
    public static Map<String, Marketing_Community__c> myCommunityMap {
        get {
            if(myCommunityMap == null){
                myCommunityMap = new Map<String, Marketing_Community__c>();
                for(Marketing_Community__c comm: myCommunityList) {
                    myCommunityMap.put(comm.Name, comm);
                }
            }
            return myCommunityMap;
        }
        set;
    }
    public static List <subdivision__c> mysubdivisionList {
        get {
            if(mysubdivisionlist == null){
                mysubdivisionlist= [SELECT Name, Id From subdivision__c];
            }
        return mysubdivisionlist;
        }
    set;
    }
    
    public static Map<String, subdivision__c> mysubdivisionMap {
        get {
            if(mysubdivisionMap == null){
                mysubdivisionMap = new Map<String, subdivision__c>();
                for(subdivision__c sub: mysubdivisionlist ) {
                    mysubdivisionMap.put(sub.Name, sub);
                }
            }
            return mysubdivisionMap;
        }
        set;
    }
     public static Map<Id,String> mysubdivisionIdMap {
        get {
            if(mysubdivisionIdMap == null){
                mysubdivisionIdMap = new Map<Id,String>();
                for(subdivision__c sub: mysubdivisionList) {
                    mysubdivisionIdMap.put(sub.Id,sub.Name);
                }
            }
            return mysubdivisionIdMap ;
        }
        set;
    }
     public static Map<Id,String> myCommunityIdMap {
        get {
            if(myCommunityIdMap == null){
                myCommunityIdMap = new Map<Id,String>();
                for(Marketing_Community__c comm: myCommunityList) {
                    myCommunityIdMap.put(comm.Id,comm.Name);
                }
            }
            return myCommunityIdMap;
        }
        set;
    }
     public static Map<Id,String> mySalesOfficeIdMap {
        get {
            if(mySalesOfficeIdMap == null){
                mySalesOfficeIdMap = new Map<Id,String>();
                for(Sales_office__c soff: mySalesofficeList ) {
                    mySalesOfficeIdMap.put(soff.Id,soff.Name);
                }
            }
            return mySalesOfficeIdMap ;
        }
        set;
    }
    public static List <Sales_office__c> mySalesofficeList {
        get {
            if(mySalesofficeList == null){
                mySalesofficeList = [SELECT Name, Id From Sales_office__c];
            }
        return mySalesofficeList ;
        }
    set;
    }
     public static Map<String, Sales_office__c> mySalesofficeMap {
        get {
            if(mySalesofficeMap == null){
                mySalesofficeMap = new Map<String, Sales_office__c>();
                for(Sales_office__c soff: mySalesofficeList ) {
                    mySalesofficeMap.put(soff.Name, soff);
                }
            }
            return mySalesofficeMap ;
        }
        set;
    }


     public static List <Profile> myProfileList {
        get {
            if(myProfileList == null){
                myProfileList = [SELECT name, Id From Profile];
            }
        return myProfileList;
        }
    set;
    }

    public static Map<String, Profile> myProfileMap {
        get {
            if(myProfileMap == null){
                myProfileMap = new Map<String, Profile>();
                for(Profile prof: myProfileList) {
                    myProfileMap.put(prof.Name, prof);
                }
            }
            return myProfileMap;
        }
        set;
    }

    public static List <UserRole> myUserRoleList {
        get {
            if(myUserRoleList == null){
                myUserRoleList = [SELECT name, Id From UserRole];
            }
        return myUserRoleList;
        }
    set;
    }

    public static Map<String, UserRole> myUserRoleMap {
        get {
            if(myUserRoleMap == null){
                myUserRoleMap = new Map<String, UserRole>();
                for(UserRole role: myUserRoleList) {
                    myUserRoleMap.put(role.Name, role);
                }
            }
            return myUserRoleMap;
        }
        set;
    }
     public static Map<Id, string> UserRoleMap {
        get {
            if(UserRoleMap == null){
                UserRoleMap = new Map<Id, string>();
                for(UserRole role: myUserRoleList) {
                    UserRoleMap.put(role.Id, role.Name);
                }
            }
            return UserRoleMap;
        }
        set;
    }  
     public static Map<Id, Id> BRPUserRoleMap 
     {
        get {
            if(BRPUserRoleMap == null)
            {
                BRPUserRoleMap = new Map<Id, Id>();
                for(User usr: [Select Id, UserRole.Id from User])
                {
                    BRPUserRoleMap.put(usr.Id, usr.Userrole.Id);
                }

            }
            return BRPUserRoleMap;
        }
         set;
     }
    
    
}