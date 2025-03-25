from rest_framework import serializers
from .models import Booking

class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = '__all__'
        read_only_fields = ('user', 'created_at')  # Prevent manual setting of these fields

    def validate_booking_date(self, value):
        # Add any custom date validation if needed
        # For example, ensure booking date is in the future
        import datetime
        if value < datetime.datetime.now():
            raise serializers.ValidationError("Booking date must be in the future")
        return value