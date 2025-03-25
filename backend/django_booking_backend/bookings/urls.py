from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views
from .views import CustomAuthToken  # if in the same directory

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api-token-auth/', CustomAuthToken.as_view()),
    path('api/', include('bookings.urls')),
]