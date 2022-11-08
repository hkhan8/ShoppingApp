using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingApp.Data;
using ShoppingApp.Models;
using System.Diagnostics;

namespace ShoppingApp.Controllers
{
    public class ItemsController : Controller
    {
        private readonly ShoppingListContext _context;

        public ItemsController(ShoppingListContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Returns the Index Page (the table will be a partial view)
        /// </summary>
        /// <returns></returns>
        public async Task<IActionResult> Index()
        {
            return View(await GetItemData());
        }

        public async Task<IActionResult> About()
        {
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

        public async Task<IActionResult> CreatePartial()
        {
            return PartialView("_CreateItem");
        }

        public async Task<IActionResult> EditPartial(int id)
        {
            var item = await _context.Items.FindAsync(id);
            return item == null ? NotFound() : PartialView("_EditItem", item);
        }

        public async Task<IActionResult> DetailsPartial(int id)
        {
            var item = await _context.Items.FindAsync(id);
            return item == null ? NotFound() : PartialView("_DetailsItem", item);

        }

        private async Task<List<Item>> GetItemData()
        {
            return await _context.Items.ToListAsync();
        }

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

        private bool ItemExists(int id)
        {
            return _context.Items.Any(e => e.Id == id);
        }
    }



}