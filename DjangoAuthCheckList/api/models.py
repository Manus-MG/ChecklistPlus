from django.db import models

# Create your models here.
class Todo(models.Model):
    # user=models.ForeignKey(user,on_delete=models.CASCADE,null=true)
    title = models.CharField(max_length = 50)
    desc = models.CharField(max_length = 200)
    isDone = models.BooleanField(default = False)
    date = models.DateTimeField(auto_now_add = True)
    email = models.EmailField(default ="")


    def __str__(self):
        return self.title