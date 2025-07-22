using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using PearlFurniture.Areas.Identity.Data;
using PearlFurniture.Models;


public class ProfileController : Controller
{
    private readonly UserManager<PearlFurnitureUser> _userManager;

    public ProfileController(UserManager<PearlFurnitureUser> userManager)
    {
        _userManager = userManager;
    }

    [Authorize]
    public async Task<IActionResult> Index()
    {
        var user = await _userManager.GetUserAsync(User);

        if (user == null)
            return NotFound();

        var model = new UserProfileViewModel
        {
            FullName = user.UserName!,
            Email = user.Email!,
            PhoneNumber = user.PhoneNumber!,
            CustomerAge = user.CustomerAge,
            CustomerAddress = user.CustomerAddress!,
            CustomerDOB = user.CustomerDOB
        };

        return View();
    }

}
