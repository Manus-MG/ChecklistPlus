from django.db import models
# from django.contrib.auth.models import UserProfile

class UserProfile(models.Model):
    # UserProfile = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    about = models.TextField(blank=True, null=True)
    profile_picture = models.ImageField(upload_to='profile_pictures/', blank=True, null=True)

    def __str__(self):
        return self.name

    def delete(self, *args, **kwargs):
        # Delete the profile picture file when the user is deleted
        self.profile_picture.delete()
        super(UserProfile, self).delete(*args, **kwargs)
