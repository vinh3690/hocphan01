using System.ComponentModel.DataAnnotations;

namespace ProjectTest1.Models
{
    public class UserModel
    {
        public Guid Id { get; set; } = Guid.NewGuid();

        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string PasswordHash { get; set; }

        [Required]
        public string FullName { get; set; }

        [Phone]
        public string Phone { get; set; }

        public string Address { get; set; }

        public bool IsEmailConfirmed { get; set; } = false;

        public string? ResetToken { get; set; }

        public DateTime? ResetTokenExpiry { get; set; }

        public string Role { get; set; } = "User";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
