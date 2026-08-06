from django.contrib import admin
from .models import Adventure, Act, Actor, Environment, Puzzle, PuzzleSolution


# This is to add Acts In line in Adventure page
class ActInLine(admin.StackedInline):
    model = Act
    extra = 1 # Add Another act forms shown by default
    ordering = ("order",)
    filter_horizontal = ("actors", "environments", "puzzles")

# This adds Puzzle solutions in line to Puzzles
class PuzzleSolutionInline(admin.TabularInline):
    model = PuzzleSolution
    extra = 1
    ordering = ("tier",)

# Registering the Adventure and what will be displayed 
@admin.register(Adventure)
class AdventureAdmin(admin.ModelAdmin):
    list_display = ("title", "status", "created_at")
    inlines = [ActInLine]
    
# Registering the Acts, what will be displayed, and the filter
@admin.register(Act)
class ActAdmin(admin.ModelAdmin):
    list_display = ("__str__", "adventure", "order")
    list_filter = ("adventure",)
    filter_horizontal = ("actors", "environments", "puzzles")

# Registering Actors
@admin.register(Actor)
class ActorAdmin(admin.ModelAdmin):
    list_display = ("name", "kind", "tier", "actor_type")
    
# Environments
@admin.register(Environment)
class EnvironmentAdmin(admin.ModelAdmin):
    list_display = ("name", "tier", "environment_type")

# Puzzles 
@admin.register(Puzzle)
class PuzzleAdmin(admin.ModelAdmin):
    list_display = ("name", "status")
    inlines = [PuzzleSolutionInline]