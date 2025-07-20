using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using PearlFurniture.Data;
using PearlFurniture.Areas.Identity.Data;


var builder = WebApplication.CreateBuilder(args);

// Database context
var connectionString = builder.Configuration.GetConnectionString("PearlFurnitureContextConnection")
                      ?? throw new InvalidOperationException("Connection string 'PearlFurnitureContextConnection' not found.");

builder.Services.AddDbContext<PearlFurnitureContext>(options =>
    options.UseSqlServer(connectionString));

// Identity setup
builder.Services.AddDefaultIdentity<PearlFurnitureUser>(options =>
{
    options.SignIn.RequireConfirmedAccount = false; // or true, as needed
})
.AddRoles<IdentityRole>()
.AddEntityFrameworkStores<PearlFurnitureContext>();





// MVC & Razor
builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();

var app = builder.Build();


using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    await SeedRolesAsync(services);
}

// Middleware pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseDefaultFiles();
app.UseStaticFiles();

app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.MapRazorPages();
app.Run();


static async Task SeedRolesAsync(IServiceProvider serviceProvider)
{
    var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
    var roles = new List<string> { "Admin", "Customer" }; // Simplified collection initialization

    foreach (var role in roles)
    {
        if (!await roleManager.RoleExistsAsync(role))
        {
            await roleManager.CreateAsync(new IdentityRole(role));
        }
    }
}


