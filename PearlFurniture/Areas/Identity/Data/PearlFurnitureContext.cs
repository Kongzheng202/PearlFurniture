using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using PearlFurniture.Areas.Identity.Data;

namespace PearlFurniture.Data;

public class PearlFurnitureContext : IdentityDbContext<PearlFurnitureUser>
{
    public PearlFurnitureContext(DbContextOptions<PearlFurnitureContext> options)
        : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        // Customize the ASP.NET Identity model and override the defaults if needed.
        // For example, you can rename the ASP.NET Identity table names and more.
        // Add your customizations after calling base.OnModelCreating(builder);
    }
}
