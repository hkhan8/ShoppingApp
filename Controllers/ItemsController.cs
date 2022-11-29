using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingApp.Data;
using ShoppingApp.Models;
using System.Diagnostics;

namespace ShoppingApp.Controllers
{
    public class ItemsController : Controller
    {
        /// <summary>
        /// The _context.
        /// </summary>
        private readonly ShoppingListContext _context;

        /// <summary>
        /// ItemsController.
        /// </summary>
        /// <param name="context"></param>
        public ItemsController(ShoppingListContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Returns the Index Page (the table will be a partial view)
        /// </summary>
        /// <returns></returns>
        /// 
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            ViewData["UserId"] = HttpContext.Session.GetString("appUserSession");
            return View(await GetItemData());
        }

        /// <summary>
        /// About page
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> About()
        {
            ViewData["UserId"] = HttpContext.Session.GetString("appUserSession");
            return View();
        }

        /// <summary>
        /// Returns just the data required to render the table
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> ItemTable()
        {
            await Task.Delay(3000);
            return PartialView("_ItemTable", await GetItemData());
        }

        /// <summary>
        /// Get Create Item View.
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> CreatePartial()
        {
            return PartialView("_CreateItem");
        }

        /// <summary>
        /// Edit Items.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public async Task<IActionResult> EditPartial(int id)
        {
            var item = await _context.Items.FindAsync(id);
            return item == null ? NotFound() : PartialView("_EditItem", item);
        }

        /// <summary>
        /// Delete Item.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public async Task<IActionResult> DetailsPartial(int id)
        {
            var item = await _context.Items.FindAsync(id);
            return item == null ? NotFound() : PartialView("_DetailsItem", item);

        }

        /// <summary>
        /// Get all items.
        /// </summary>
        /// <returns></returns>
        private async Task<List<Item>> GetItemData()
        {
            return await _context.Items.ToListAsync();
        }

        /// <summary>
        /// Remove item by Id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        [HttpDelete]
        public async Task<IActionResult> DeleteItem(int id)
        {
            var item = await _context.Items.FindAsync(id);

            if (item == null)
            {
                return NotFound();
            }

            _context.Items.Remove(item);
            await _context.SaveChangesAsync();
            return Ok();
        }


        // POST: Items/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Item item)
        {
            if (ModelState.IsValid)
            {
                _context.Add(item);
                await _context.SaveChangesAsync();
                return Ok();
            }
            return BadRequest();
        }


        // POST: Items/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPut]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(Item item)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(item);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ItemExists(item.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return Ok();
            }
            return BadRequest();
        }

        /// <summary>
        /// Check if item already exist.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        private bool ItemExists(int id)
        {
            return _context.Items.Any(e => e.Id == id);
        }
    }



}