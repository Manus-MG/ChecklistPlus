# api/views.py

from rest_framework import generics
from .models import Todo
from .serializers import TodoSerilizer

class TodoGetCreate(generics.ListCreateAPIView):
    serializer_class = TodoSerilizer

    def get_queryset(self):
        queryset = Todo.objects.all()
        email = self.request.query_params.get('email', None)
        isdone = self.request.query_params.get('isDone', None)
        if email is not None:
            queryset = queryset.filter(email=email)
        if isdone is not None:
            queryset = queryset.filter(isDone=isdone.lower() == 'true')
        return queryset


class TodoUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerilizer
    def get_queryset(self):
        queryset = Todo.objects.all()
        email = self.request.query_params.get('email', None)
        isdone = self.request.query_params.get('isDone', None)

        if email is not None:
            queryset = queryset.filter(email=email)
        if isdone is not None:
            queryset = queryset.filter(isDone=isdone.lower() == 'true')
        
        return queryset




# 127.0.0.1 
# 10.0.2.2:8000 