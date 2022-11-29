using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ShoppingApp.Data;
using ShoppingApp.Models;

namespace ShoppingApp.Controllers
{
    public class ShoppingListController : Controller
    {
        /// <summary>
        /// The _context.
        /// </summary>
        private readonly ShoppingListContext _context;

        /// <summary>
        /// The ShoppingListController.
        /// </summary>
        /// <param name="context"></param>
        public ShoppingListController(ShoppingListContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Get index view.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public IActionResult Index()
        {
            ViewData["UserId"] = HttpContext.Session.GetString("appUserSession");
            return View();
        }

        #region PartialViews

        /// <summary>
        /// Get shopingList item view by userID.
        /// </summary>
        /// <param name="userID">The userID</param>
        /// <returns></returns>
        public async Task<IActionResult> ShoppingListDDLPartial(int userID)
        {
            // Get all Shopping Lists
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

        /// <summary>
        /// Get shoppingList view.
        /// </summary>
        /// <param name="shoppingListId">The shoppingListId.</param>
        /// <returns></returns>
        public async Task<IActionResult> ShoppingListTablePartial(int shoppingListId)
        {
            var items = await _context.ShoppingItems.Include(c => c.Item)
                                                         .Where(c => c.ShoppingListId == shoppingListId)
                                                         .Select(c => c.Item)
                                                         .ToListAsync();

            var itemViewModel = items.Select(x => new ItemViewModel {
                Id = x.Id,
                ItemName = x.ItemName,
                Quantity = _context.ShoppingItems.Where(c => c.ShoppingListId == shoppingListId && c.ItemId == x.Id).FirstOrDefault()!.Quantity,
                Unit = x.Unit,
                UnitPrice = x.UnitPrice,
            });

            var dateTime = await _context.ShoppingLists
                    .Where(c => c.ShoppingListId == shoppingListId).FirstOrDefaultAsync();
            ViewData["Total"] = Math.Round(itemViewModel.Sum(x => ((double)x.Quantity * x.UnitPrice)), 2);
            ViewData["CreatedDate"] = dateTime != null ? dateTime!.CreatedDate.Date.ToString("MM-dd-yyyy") : null;

            return PartialView("_ShoppingListTable", itemViewModel);
        }

        /// <summary>
        /// Get list of items.
        /// </summary>
        /// <param name="listId">The listId.</param>
        /// <param name="searchCriteria">The searchCriteria.</param>
        /// <returns></returns>
        public async Task<IActionResult> GetNotAddedItemsForShoppingListPartial(int listId, string searchCriteria = "")
        {

            searchCriteria = searchCriteria == null ? "" : searchCriteria;

            var allItems = _context.Items.Where(c => c.ItemName.ToLower().StartsWith(searchCriteria.ToLower())).Select(x => new ItemViewModel
            {
                Id = x.Id,
                ItemName = x.ItemName,
                Unit = x.Unit,
                UnitPrice = x.UnitPrice,
            }).AsEnumerable();

            var addedItems = _context.ShoppingItems.Where(c => c.ShoppingListId == listId)
                                                          .Include(c => c.Item)
                                                          .Select(x => x.ItemId)
                                                          .ToList();


            var notSelectedItems = allItems.Where(x => !addedItems.Contains(x.Id)).ToList();

            return PartialView("_GetNotAddedItemsForShoppingList", notSelectedItems);
        }

        #endregion

        /// <summary>
        /// Get shpping list
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> ShoppingList()
        {
            ViewData["UserId"] = HttpContext.Session.GetString("appUserSession");
            var userId = Convert.ToInt32(HttpContext.Session.GetString("appUserSession"));
            // Get all Shopping Lists
            var shoppingLists = await _context.ShoppingLists!.Where(c => c.UserId == userId).ToListAsync();

            // Return the Partial View
            return View("ShoppingListView", shoppingLists);
        }

        /// <summary>
        /// Get shopping list details by shoppingId
        /// </summary>
        /// <param name="shoppingListId">The shoppingListId</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> EditShoppingListDetails(int ShoppingListId)
        {
            // Get all Shopping Lists
            var shoppingListObject = await _context.ShoppingLists!.Where(c => c.ShoppingListId == ShoppingListId).FirstOrDefaultAsync();

            if (shoppingListObject != null)
            {
                // Return the Partial View
                return View("ShoppingListEditView", shoppingListObject);
            }

            return RedirectToAction("ShoppingList");
        }

        /// <summary>
        /// Update shopping list details by shoppingId
        /// </summary>
        /// <param name="shoppingList">The shoppingList</param>
        /// <returns></returns>
        [HttpPut]
        public async Task<IActionResult> EditShoppingListDetails(int ShoppingListId, ShoppingList shoppingList)
        {
            // Get all Shopping Lists
            var shoppingLists = await _context.ShoppingLists!.Where(c => c.ShoppingListId == ShoppingListId).FirstOrDefaultAsync();

            //validation check
            if (shoppingLists != null)
            {
                //set newly updated properties
                shoppingLists!.Name = shoppingList.Name;
                shoppingLists.CreatedDate = DateTime.Now.Date;

                _context.ShoppingLists!.Update(shoppingLists);
                await _context.SaveChangesAsync();
            }

            var result = new { Success = "True", Message = "Updated Successfully" };
            return Json(result);
        }

        /// <summary>
        /// delete shopping list by shoppingId
        /// </summary>
        /// <param name="shoppingListId">The shoppingListId</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> DeleteShoppingListDetails(int ShoppingListId)
        {
            // Get all Shopping Lists
            var shoppingLists = await _context.ShoppingLists!.Where(c => c.ShoppingListId == ShoppingListId).FirstOrDefaultAsync();

            if (shoppingLists != null)
            {
                _context.ShoppingLists!.Remove(shoppingLists);
                await _context.SaveChangesAsync();
            }

            // Return the Partial View
            return RedirectToAction("ShoppingList");
        }

        #region CRUD Methods

        /// <summary>
        /// Remove item from list.
        /// </summary>
        /// <param name="itemId">The itemId</param>
        /// <param name="shoppingListId">The shoppingListId</param>
        /// <returns></returns>
        [HttpDelete]
        public async Task<IActionResult> RemoveItemFromList(int itemId, int shoppingListId)
        {
            //Get all Shopping Lists
            var shoppingListItem = _context.ShoppingItems.Where(c => c.ItemId == itemId && c.ShoppingListId == shoppingListId)
                                                         .FirstOrDefault();
            //validation check on shoppinglist item
            if (shoppingListItem == null)
            {
                return BadRequest();
            }
            _context.ShoppingItems.Remove(shoppingListItem);
            await _context.SaveChangesAsync();
            return Ok();

        }

        /// <summary>
        /// Add item to the list
        /// </summary>
        /// <param name="item">The item.</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> AddItemToShoppingList([FromBody] ShoppingListItem item)
        {

            //item.Quantity = item.Quantity == 0 ? 1 : item.Quantity;        
            
            if (!ModelState.IsValid && item != null)
            {
                //validation check for quantity 
                if (item.Quantity > 50)
                {
                    return BadRequest("Max quantity per Product is 50!");
                }
                item.Quantity = item.Quantity == 0 ? 1 : item.Quantity;

                _context.ShoppingItems.Add(item);
                await _context.SaveChangesAsync();
                return Ok();                
            }

            return BadRequest("Please provide proper details.");
        }

        /// <summary>
        /// Update shoping list
        /// </summary>
        /// <param name="userId">The userId</param>
        /// <param name="listName">The listName</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> AddNewShoppingList([FromQuery] int userId, [FromBody] string listName)
            {

            //validation check
            if (String.IsNullOrEmpty(listName) || userId == 0)
            {
                return BadRequest("The listName must have a value, and the user must be valid");
            }

            //instantiation of ShoppingLsit
            ShoppingList newList = new ShoppingList
            {
                UserId = userId,
                Name = listName
            };

            var existingList = _context.ShoppingLists.Where(c => c.Name.Equals(listName) && c.UserId == userId).FirstOrDefault();
            
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
