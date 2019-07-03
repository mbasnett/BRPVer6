({
  // Client-side function that invokes the subscribe method on the
  // empApi component.
  subscribe: function (component, event, helper) {
    // Get the empApi component.
    const empApi = component.find('empApi');
    // Get the channel from the attribute.
    const channel = component.get('v.channel');
    // Subscription option to get only new events.
    const replayId = -1;
    // Callback function to be passed in the subscribe call.
    // After an event is received, this callback prints the event
    // payload to the console. A helper method displays the message
    // in the console app.
    const callback = function (message) {
      console.log('Event Received : ' + JSON.stringify(message));
      helper.onReceiveNotification(component, message);
    };
    // Subscribe to the channel and save the returned subscription object.
      empApi.subscribe(channel, replayId, $A.getCallback(callback)).then($A.getCallback(function (newSubscription) {
      console.log('Subscribed to channel ' + channel);
      component.set('v.subscription', newSubscription);
    }));
  },
  onReceiveNotification: function (component, message) {
     component.set('v.Spinner', !component.get('v.Spinner'));
     var recordid=  message.data.payload.recordid__c;
     var navEvt = $A.get("e.force:navigateToSObject");
           navEvt.setParams({
            "recordId": recordid ,
           });
           navEvt.fire();
    const empApi = component.find('empApi');
    empApi.unsubscribe(component.get('v.subscription'), null);
    
  },
})