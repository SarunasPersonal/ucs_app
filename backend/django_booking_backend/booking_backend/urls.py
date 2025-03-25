from django.contrib import admin
from django.urls import path, include
from .views import CustomAuthTokenView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api-token-auth/', CustomAuthTokenView.as_view()),
    path('api/', include('bookings.urls')),
]