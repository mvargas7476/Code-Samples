from django.db import transaction
from rest_framework import serializers
from .models import Adventure, Act, Actor, Environment, Puzzle, PuzzleSolution

class AdventureSerializer(serializers.ModelSerializer):
    class Meta:
        model = Adventure
        fields = ["id", "title", "story_setting", "description", "status",
                  "created_at", "updated_at"]
        read_only_fields = ["id", "created_at", "updated_at"]


class ActSerializer(serializers.ModelSerializer):
    class Meta:
        model = Act
        fields = ["id", "adventure", "order", "title", "summary", "plot_hooks",
                  "story_beats", "climax", "gm_notes", "actors",
                  "environments", "puzzles", "created_at", "updated_at"]
        read_only_fields = ["id", "created_at", "updated_at"]
        
        
class ActorSerializer(serializers.ModelSerializer):
    factions = serializers.ListField(
        child=serializers.CharField(),
        required=False,
    )
    class Meta:
        model = Actor
        fields = ["id", "name", "kind", "motivation", "description",
                  "tier", "actor_type", "factions", "notes", "stats", 
                  "abilities", "features", "created_at", "updated_at"]
        read_only_fields = ["id", "created_at", "updated_at"]
        
class EnvironmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Environment
        fields = ["id", "name", "description", "sensory_details", 
                  "hazards", "secrets", "notes", "tier",
                  "environment_type", "created_at", "updated_at"]
        read_only_fields = ["id", "created_at", "updated_at"]
        
        
class PuzzleSolutionSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField(required=False)
    class Meta:
        model = PuzzleSolution
        fields = ["id", "tier", "solution_type", "description", "notes"]
        
class PuzzleSerializer(serializers.ModelSerializer):
    # Implementing the Puzzle Solution into the Puzzle endpoint
    solutions = PuzzleSolutionSerializer(many=True)
    class Meta:
        model = Puzzle
        fields = ["id", "name", "description", "notes", "status",
                  "solutions", "created_at", "updated_at"]
        read_only_fields = ["id", "created_at", "updated_at"]
        
    # Creating the validation that we need at least 2 solutions that are correct and alternate
    def validate_solutions(self, value):
        real = [
            s for s in value if s.get("solution_type") in {
                PuzzleSolution.SolutionType.CORRECT,
                PuzzleSolution.SolutionType.ALTERNATE,
            }
        ]
        if (len(real) < 2):
            raise serializers.ValidationError(
                "A puzzle needs at least 2 solutions (red herrings don't count)"
            )
        
        return value
    
    # This is what we use to create a Puzzle since it has the Puzzle Solutions, we need this
    def create(self, validated_data):
        solutions_data = validated_data.pop("solutions")
        
        # Adding Atomic so transactions are done individually
        with transaction.atomic():
            puzzle = Puzzle.objects.create(**validated_data)
            
            for sol in solutions_data:
                # Here we create a solution with the parameters passed, but we ignore the id
                PuzzleSolution.objects.create(puzzle=puzzle, **{k: v for k, v in sol.items() if k != "id"})

        
        return puzzle
    
    # This is what we use to update a Puzzle since it has the Puzzle Solutions, we need this
    def update(self, instance, validated_data):
        solutions_data = validated_data.pop("solutions", None)
        
        # Adding Atomic so transactions are done individually
        with transaction.atomic():              
            for attr, val in validated_data.items():
                setattr(instance, attr, val)
            instance.save()
            
            if (solutions_data is not None):
                # Map current solutions by id so we can match incoming solutions
                existing = {s.id: s for s in instance.solutions.all()}
                seen_ids = set()

                for sol in solutions_data:
                    sol_id = sol.get("id")
                    # If we have a known id, we maintain it
                    if (sol_id in existing):
                        obj = existing[sol_id]
                        for attr, val in sol.items():
                            if attr != "id":
                                setattr(obj, attr, val)
                        obj.save()
                        seen_ids.add(sol_id)
                    else:
                        # No id, this creates a solution and skips the id
                        # Also we add a solution with the parameters passed, but we ignore the id
                        PuzzleSolution.objects.create(puzzle=instance, **{k: v for k, v in sol.items() if k != "id"})

                # Any existing solution the client deleted, we remove from the obejct
                for sol_id, obj in existing.items():
                    if sol_id not in seen_ids:
                        obj.delete()
            
        return instance
    
    
# Adding a place for all of the Act Details to be added. Using ActSerializer as a base
class ActDetailSerializer(ActSerializer):
    # Adding Actors, Environments, and Puzzles to the Act Details endpoint
    actors = ActorSerializer(many=True, read_only=True)
    environments = EnvironmentSerializer(many=True, read_only=True)
    puzzles = PuzzleSerializer(many=True, read_only=True)
    
# Here is a quick summary serializer for acts to use in the Adventures Details
class ActSummarySerializer(serializers.ModelSerializer):
    class Meta:
        model = Act
        fields = ["id", "order", "title", "summary"]
    
# Adding a place for all adventure Details Using the Adventure serializer as a base
class AdventureDetailSerializer(AdventureSerializer):
    acts = ActSummarySerializer(many=True, read_only=True)
    
    class Meta(AdventureSerializer.Meta):
        fields = AdventureSerializer.Meta.fields + ["acts"]