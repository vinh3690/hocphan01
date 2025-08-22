using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProjectTest1.Migrations
{
    /// <inheritdoc />
    public partial class AddCreatedAtToProductImageModel : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Create",
                table: "Product",
                newName: "CreatedAt");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "CreatedAt",
                table: "Product",
                newName: "Create");
        }
    }
}
