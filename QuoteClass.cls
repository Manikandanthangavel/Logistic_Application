public class QuoteClass 
{
    public static void TriggerMethod(List<Customer_Order__c> OrderList)
    {
        List<Id> CID=new List<Id>();
        List<Quotation__c> QuotationsforOrderList=new List<Quotation__c>();
        for(Customer_Order__c order:OrderList)
        {
            CID.add(order.Customer__c); 
        }
        List<Customer__c> custList=[select Id,Name,Last_Name__c from Customer__c where Id in:CID];
        List<String> custNameList=new List<String>();
        for(Customer__c CObj:custList)
        {
            String Name=CObj.Name+CObj.Last_Name__c;
            custNameList.add(Name);
        }
        for(Customer_Order__c order:OrderList)
        {
            for(String FName:custNameList)
            {
                String QName='Quote for '+FName;
                Quotation__c newQuote=new Quotation__c(Name=QName,Logistics_Order__c=order.Id,Customer__c=order.Customer__c);
                QuotationsforOrderList.add(newQuote);
            }
        }
        insert QuotationsforOrderList;
        
    }
    
}