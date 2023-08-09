from django.contrib import admin
from django.urls import path, include
# from django.contrib import admin
# from django.urls import path
from django.urls.conf import include
from profilepage import views
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/user/', include('account.urls')),
    path('', include('api.urls')),
    path('profile/', views.UserProfileListCreateView.as_view(), 
         name='profile-list-create'),
    path('profile/<int:pk>/', views.UserProfileRetrieveUpdateDestroyView.as_view(), 
         name='profile-detail'),
    
]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)