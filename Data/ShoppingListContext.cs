using Microsoft.EntityFrameworkCore;
using ShoppingApp.Models;

namespace ShoppingApp.Data
{
    public class ShoppingListContext : DbContext
    {
        public ShoppingListContext(DbContextOptions<ShoppingListContext> options)
            : base(options)
        {
        }

        public DbSet<Item>? Items { get; set; }
        public DbSet<ShoppingList>? ShoppingLists { get; set; }
        public DbSet<ShoppingListItem>? ShoppingItems { get; set; }
        public DbSet<User>? Users { get; set; }
    }
}