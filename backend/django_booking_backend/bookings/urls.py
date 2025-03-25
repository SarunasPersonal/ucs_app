from django.urls import path
from rest_framework.authtoken import views
from .views import BookingListCreateView, BookingRetrieveUpdateDestroyView

urlpatterns = [
    # Authentication route (if you want a custom implementation)
    # path('token/', CustomAuthToken.as_view(), name='api-token-auth'),
    
    # Booking list and create
    path('bookings/', BookingListCreateView.as_view(), name='booking-list-create'),
    
    # Booking retrieve, update, and delete
    path('bookings/<int:pk>/', BookingRetrieveUpdateDestroyView.as_view(), name='booking-detail'),
]