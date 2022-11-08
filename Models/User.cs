using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ShoppingApp.Models
{
    public class User
    {
        public int UserId { get; set; }
        [DisplayName("User Name")]
        [Required(ErrorMessage = "Field is required")]
        public string UserName { get; set; }
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Field is required")]
        public string Password { get; set; }
    }
}
