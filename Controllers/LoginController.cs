using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingApp.Data;
using ShoppingApp.Models;

namespace ShoppingApp.Controllers
{
    public class LoginController : Controller
    {
        /// <summary>
        /// The _context.
        /// </summary>
        private readonly ShoppingListContext _context;

        /// <summary>
        /// The LoginController.
        /// </summary>
        /// <param name="context">The context.</param>
        public LoginController(ShoppingListContext context)
        {
            _context = context;
        }

        /// <summary>
        /// The Index View.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            ViewData["UserId"] = HttpContext.Session.GetString("appUserSession");
            return View(await _context.Users.ToListAsync());
        }

        /// <summary>
        /// The Login View.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> LoginPage()
        {
            return View();
        }

        /// <summary>
        /// Check login details.
        /// </summary>
        /// <param name="model">The model.</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> LoginPage(User model)
        {
            if (ModelState.IsValid)
            {
                var User = from m in _context.Users select m;
                var loggedInUser = User.Where(s => s.UserName.Contains(model.UserName)).FirstOrDefault();
                if (loggedInUser != null)
                {
                    if (loggedInUser.Password == model.Password)
                    {
                        HttpContext.Session.SetString("appUserSession", loggedInUser.UserId.ToString());
                        return RedirectToAction("Index", "Items");
                    }
                }
            }
            ModelState.AddModelError("", "Invalid User Login or Pass");
            return View(model);
        }

        /// <summary>
        /// Logout. Remove session user.
        /// </summary>
        /// <returns></returns>

        [HttpGet]
        public async Task<IActionResult> LogOut()
        {
            HttpContext.Session.SetString("appUserSession", "");
            HttpContext.Session.Clear();
            return RedirectToAction("LoginPage");
        }

        /// <summary>
        /// Get details of user by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        [HttpGet]
        // GET: Users/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.UserId == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        /// <summary>
        /// Create user view.
        /// </summary>
        /// <returns></returns>
        // GET: Users/Create
        public IActionResult Create()
        {
            return View();
        }

        //POST: Users/Create
        //To protect from overposting attacks, enable the specific properties you want to bind to.
        //For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        /// <summary>
        /// Create user
        /// </summary>
        /// <param name="user">The user.</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,UserName,Password")] User user)
        {
            if (ModelState.IsValid)
            {
                _context.Add(user);
                await _context.SaveChangesAsync();
                return RedirectToAction("LoginPage", "Login");
            }
            return View(user);
        }

        // GET: Users/Edit/5
        /// <summary>
        /// Get user details by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        /// 
        [HttpGet]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            return View(user);
        }

        // POST: Users/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        /// <summary>
        /// Edit user details
        /// </summary>
        /// <param name="user">The user.</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit([Bind("UserId,UserName,Password")] User user)
        {
            var _user = _context.Users.Where(x => x.UserId == user.UserId).FirstOrDefault();
            if (user.UserId == 0)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _user.UserName = user.UserName;
                    _user.Password = user.Password;
                    _context.Update(_user);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserExists(user.UserId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(user);
        }

        // GET: Users/Delete/5
        /// <summary>
        /// Remove user by userId
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>

        [HttpGet]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.UserId == id);
            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        // POST: Users/Delete/5
        /// <summary>
        /// Confirm delete.
        /// </summary>
        /// <param name="id">The id</param>
        /// <returns></returns>
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var user = await _context.Users.FindAsync(id);
            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserId == id);
        }
    }
}

