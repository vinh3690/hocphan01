using Microsoft.EntityFrameworkCore;
using ProjectTest1.Models;
using System.Drawing;

namespace ProjectTest1.Repository
{
    public class DataContext:DbContext
    {
        public DataContext(DbContextOptions<DataContext> options)
            : base(options) {
        }
        public DbSet<CategoryModel> Categories { get; set; }
        public DbSet<ColorModel> Colors { get; set; }
        public DbSet<SizeModel> Sizes { get; set; }
        public DbSet<ProductModel> Product { get; set; }
        public DbSet<ProductVariantModel> ProductVariants { get; set; }
        public DbSet<ProductImageModel> ProductImages { get; set; }
        public DbSet<CartModel> CartModels { get; set; }
        public DbSet<CartItemModel> CartItemModels { get; set; }
        public DbSet<UserModel> User { get; set; }
    }
}
