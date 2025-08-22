namespace ProjectTest1.ViewModels
{
    public class ProductVariantViewModel
    {
        public int ProductVariantId { get; set; }
        public int ColorId { get; set; }
        public int SizeId { get; set; }
        public int StockQuantity { get; set; }
        public string? SKU { get; set; }
        public bool IsSelected { get; set; }

    }
}
