namespace ShoppingApp.Models
{
    public class Item
    {
        public int Id { get; set; }
        public string ItemName { get; set; }
        public string Unit { get; set; }
        public double UnitPrice { get; set; }

        public Item()
        {

        }

        public Item(string itemName, string unit, double unitPrice)
        {
            ItemName = itemName;
            Unit = unit;
            UnitPrice = unitPrice;
        }
    }
}
