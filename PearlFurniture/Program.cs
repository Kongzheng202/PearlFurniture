using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using PearlFurniture.Data;
using PearlFurniture.Areas.Identity.Data;

var builder = WebApplication.CreateBuilder(args);
var connectionString = builder.Configuration.GetConnectionString("PearlFurnitureContextConnection") ?? throw new InvalidOperationException("Connection string 'PearlFurnitureContextConnection' not found.");

builder.Services.AddDbContext<PearlFurnitureContext>(options => options.UseSqlServer(connectionString));

builder.Services.AddDefaultIdentity<PearlFurnitureUser>(options => options.SignIn.RequireConfirmedAccount = true).AddEntityFrameworkStores<PearlFurnitureContext>();

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();


app.UseDefaultFiles(); // This looks for index.html, default.html, etc. in wwwroot


app.UseStaticFiles();

app.UseRouting();
app.UseAuthentication(); // after app.UseRouting()
app.UseAuthorization();


// Optional: Keep MVC routing if you're using controllers
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.MapRazorPages(); // after app.MapControllerRoute
app.Run();

