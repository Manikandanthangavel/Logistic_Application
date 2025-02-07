public class DriverClass 
{
    public static void TriggerMethod(List<Quotation__c> QList)
    {
        List<Driver__c> DriverList=[select Id,Name,	Orders_To_be_Delivered__c,Driver_ID__c from Driver__c ];
        List<Customer_Order__c> OrdersWithDriver=new List<Customer_Order__c>();
        Id [] DriverArray=new Id[]{};
        for(Driver__c driver:DriverList)
        {
            if(driver.Orders_To_be_Delivered__c<=10)
            {
                DriverArray.add(driver.Id);
            }
        }
        List<Id>orderIDList=new List<Id>();
        for(Quotation__c Quote:QList)
        {
            orderIDList.add(Quote.Logistics_Order__c); 
        }
        List<Customer_Order__c> OrderList=[select Id,Name,Driver_Asigned__c from Customer_Order__c where Id in:orderIDList];
        for(Customer_Order__c order:OrderList)
        {
            if(DriverArray.size()>0)
            {
                order.Driver_Asigned__c=DriverArray.get(0);
                OrdersWithDriver.add(order);
            }
        }
        update OrdersWithDriver;
    }
    
}