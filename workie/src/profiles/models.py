from django.contrib.auth.models import AbstractUser
from django.db import models

class UserNet(AbstractUser):
    """ Custom user model """
    first_login = models.DateTimeField(null=True)
    last_join = models.DateTimeField(null=True)

class Profile(AbstractUser):
    """ Profile model """
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    middle_name = models.CharField(max_length=30)
    phone = models.CharField(max_length=14)
    avatar = models.ImageField(upload_to='profile/avatar/', blank=True, null=True)