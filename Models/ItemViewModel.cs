using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ShoppingApp.Models
{
    public class ItemViewModel : Item
    {
        public int Quantity { get; set; }
    }
}
