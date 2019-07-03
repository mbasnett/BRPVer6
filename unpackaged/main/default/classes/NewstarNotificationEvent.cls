/*
* Represents a NEWSTAR notification event type.
*/
public class NewstarNotificationEvent {
   
    //name of the event type
    public String Name {get; private set;}


    public NewstarNotificationEvent(String name) {
        this.Name=name;
    }

    public static NewstarNotificationEvent PendingOfferEvent { 
        get 
        {
            return new NewstarNotificationEvent('PendingOffer');
        }
    }


    public static NewstarNotificationEvent UnderContractEvent { 
        get 
        {
            return new NewstarNotificationEvent('UnderContract');
        }
    }


    public static NewstarNotificationEvent ClosedHomeEvent { 
        get 
        {
            return new NewstarNotificationEvent('Closed');
        }
    }


    public static NewstarNotificationEvent CancelledEvent { 
        get 
        {
            return new NewstarNotificationEvent('Cancelled');
        }
    }
    

    public static NewstarNotificationEvent ContingencyCreatedEvent { 
        get 
        {
            return new NewstarNotificationEvent('ContingencyCreated');
        }
    }

    public static NewstarNotificationEvent ContingencyUpdatedEvent { 
        get 
        {
            return new NewstarNotificationEvent('ContingencyUpdated');
        }
    }


    public static NewstarNotificationEvent ContingencyDeletedEvent { 
        get 
        {
            return new NewstarNotificationEvent('ContingencyDeleted');
        }
    }


    public static NewstarNotificationEvent ReservationExpiredEvent { 
        get 
        {
            return new NewstarNotificationEvent('ReservationExpired');
        }
    }


    public static NewstarNotificationEvent FinancialInfoUpdatedEvent {
        get
        {
            return new NewstarNotificationEvent('FinancialInfoUpdated');
        }
    }


    static {

    }

}