using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProjectTest1.Migrations
{
    /// <inheritdoc />
    public partial class addCart : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CartModels",
                columns: table => new
                {
                    CartId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CartModels", x => x.CartId);
                    table.ForeignKey(
                        name: "FK_CartModels_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "CartItemModels",
                columns: table => new
                {
                    CartItemId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CartId = table.Column<int>(type: "int", nullable: false),
                    ProductVariantId = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    UnitPrice = table.Column<float>(type: "real", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CartItemModels", x => x.CartItemId);
                    table.ForeignKey(
                        name: "FK_CartItemModels_CartModels_CartId",
                        column: x => x.CartId,
                        principalTable: "CartModels",
                        principalColumn: "CartId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CartItemModels_ProductVariants_ProductVariantId",
                        column: x => x.ProductVariantId,
                        principalTable: "ProductVariants",
                        principalColumn: "ProductVariantId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CartItemModels_CartId",
                table: "CartItemModels",
                column: "CartId");

            migrationBuilder.CreateIndex(
                name: "IX_CartItemModels_ProductVariantId",
                table: "CartItemModels",
                column: "ProductVariantId");

            migrationBuilder.CreateIndex(
                name: "IX_CartModels_UserId",
                table: "CartModels",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CartItemModels");

            migrationBuilder.DropTable(
                name: "CartModels");
        }
    }
}
