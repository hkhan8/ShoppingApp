using Microsoft.AspNetCore.Identity;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ShoppingApp.Models
{
    public class ShoppingList
    {
        public int ShoppingListId { get; set; }
        public string Name { get; set; }
        public int UserId { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;

        // Navigation Properties
        public User User { get; set; }
        public List<Item> Items { get; set; }
    }
}
