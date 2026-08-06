from rest_framework.routers import DefaultRouter
from .views import AdventureViewSet, ActViewSet, ActorViewSet, EnvironmentViewSet, PuzzleViewSet

router = DefaultRouter()
router.register(r"adventures", AdventureViewSet, basename="adventure")
router.register(r"acts", ActViewSet)
router.register(r"actors", ActorViewSet)
router.register(r"environments", EnvironmentViewSet)
router.register(r"puzzles", PuzzleViewSet)

urlpatterns = router.urls
