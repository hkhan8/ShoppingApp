using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ShoppingApp.Models
{
    public class ShoppingListItem
    {
        public int ShoppingListItemId { get; set; }
        public int ShoppingListId { get; set; }
        public int ItemId { get; set; }

        public int Quantity { get; set; }

        // Navigation properties

        public Item Item { get; set; }
        public ShoppingList ShoppingList { get; set; }
    }
}
