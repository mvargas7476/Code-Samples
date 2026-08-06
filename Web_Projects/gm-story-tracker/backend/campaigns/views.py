from rest_framework import viewsets
from .models import Adventure, Act, Actor, Environment, Puzzle
from .serializers import AdventureSerializer, ActSerializer, ActorSerializer, EnvironmentSerializer, PuzzleSerializer, ActDetailSerializer, AdventureDetailSerializer

class AdventureViewSet(viewsets.ModelViewSet):
    serializer_class = AdventureSerializer
    
    def get_queryset(self):
        queryset = Adventure.objects.all()
        if self.action == "retrieve":
            queryset = queryset.prefetch_related("acts")
        return queryset
    
    def get_serializer_class(self):
        if self.action == "retrieve":
            return AdventureDetailSerializer
        return AdventureSerializer

class ActViewSet(viewsets.ModelViewSet):
    queryset = Act.objects.prefetch_related("actors", "environments", "puzzles__solutions")
    serializer_class = ActSerializer
    
    def get_serializer_class(self):
        if self.action == "retrieve":
            return ActDetailSerializer
        return ActSerializer
    
class ActorViewSet(viewsets.ModelViewSet):
    queryset = Actor.objects.all()
    serializer_class = ActorSerializer
    
class EnvironmentViewSet(viewsets.ModelViewSet):
    queryset = Environment.objects.all()
    serializer_class = EnvironmentSerializer

class PuzzleViewSet(viewsets.ModelViewSet):
    queryset = Puzzle.objects.prefetch_related("solutions")
    serializer_class = PuzzleSerializer
