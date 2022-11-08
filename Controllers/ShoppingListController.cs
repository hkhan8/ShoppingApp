using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ShoppingApp.Data;
using ShoppingApp.Models;

namespace ShoppingApp.Controllers
{
    public class ShoppingListController : Controller
    {
        private readonly ShoppingListContext _context;

        public ShoppingListController(ShoppingListContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        #region PartialViews

        public async Task<IActionResult> ShoppingListDDLPartial(int userID)
        {
            // Get all Favourite Lists
            var shoppingLists = _context.ShoppingLists.Where(c => c.UserId == userID).ToList();

            // Convert our list to a Select List
            var shoppingSelectList = shoppingLists.Select(c => new SelectListItem
            {
                Text = c.Name,
                Value = c.ShoppingListId.ToString()
            }).ToList();

            // Pass the select list into the View
            ViewBag.ShoppingSelectList = shoppingSelectList;

            // Return the Partial View
            return PartialView("_ShoppingListDDL");
        }

        public async Task<IActionResult> ShoppingListTablePartial(int shoppingListId)
        {
            var items = await _context.ShoppingItems.Include(c => c.Item)
                                                         .Where(c => c.ShoppingListId == shoppingListId)
                                                         .Select(c => c.Item)
                                                         .ToListAsync();

            return PartialView("_ShoppingListTable", items);
        }

        public async Task<IActionResult> GetNotAddedItemsForShoppingListPartial(int listId, string searchCriteria = "")
        {

            searchCriteria = searchCriteria == null ? "" : searchCriteria;

            var allItems = _context.Items.Where(c => c.ItemName.ToLower().StartsWith(searchCriteria.ToLower())).AsEnumerable();

            var addedItems = _context.ShoppingItems.Where(c => c.ShoppingListId == listId)
                                                          .Include(c => c.Item)
                                                          .Select(c => c.Item)
                                                          .AsEnumerable();


            var notSelectedItems = allItems.Except(addedItems);

            return PartialView("_GetNotAddedItemsForShoppingList", notSelectedItems);
        }

        #endregion

        #region CRUD Methods


        [HttpDelete]
        public async Task<IActionResult> RemoveItemFromList(int itemId, int shoppingListId)
        {
            var shoppingListItem = _context.ShoppingItems.Where(c => c.ItemId == itemId && c.ShoppingListId == shoppingListId)
                                                         .FirstOrDefault();    
            if(shoppingListItem == null)
            {
                return BadRequest();
            }
            _context.ShoppingItems.Remove(shoppingListItem);
            await _context.SaveChangesAsync();
            return Ok();
            
        }

        [HttpPost]
        public async Task<IActionResult> AddItemToShoppingList([FromBody] ShoppingListItem item)
        {
            //swap these around
            if (!ModelState.IsValid || item == null)
            {
                _context.ShoppingItems.Add(item);
                await _context.SaveChangesAsync();
                return Ok();                
            }

            return BadRequest();
        }

        [HttpPost]
        public async Task<IActionResult> AddNewShoppingList([FromQuery] int userId, [FromBody] string listName)
        {

            if (String.IsNullOrEmpty(listName) || userId == 0)
            {
                return BadRequest("The listName must have a value, and the user must be valid");
            }

            ShoppingList newList = new ShoppingList
            {
                UserId = userId,
                Name = listName
            };

            var existingList = _context.ShoppingLists.Where(c => c.Name.Equals(listName)).FirstOrDefault();

            if (existingList != null)
            {
                return BadRequest("A List with that name already exists");
            }

            try
            {
                _context.ShoppingLists.Add(newList);
                await _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        #endregion

    }
}
