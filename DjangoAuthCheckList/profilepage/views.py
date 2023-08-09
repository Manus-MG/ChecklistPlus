from rest_framework import generics
from .models import UserProfile
from .serializers import UserProfileSerializer

class UserProfileListCreateView(generics.ListCreateAPIView):
    serializer_class = UserProfileSerializer

    def get_queryset(self):
        queryset = UserProfile.objects.all()
        search_email = self.request.query_params.get('search_email')
        if search_email:
            queryset = queryset.filter(email__icontains=search_email).order_by('-email')
        return queryset

class UserProfileRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer

    def get_queryset(self):
        queryset = UserProfile.objects.all()
        search_email = self.request.query_params.get('search_email')
        if search_email:
            queryset = queryset.filter(email__icontains=search_email).order_by('-email')
        return queryset
