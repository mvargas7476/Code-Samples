from django.db import models

# Overall adventure
class Adventure(models.Model):
    class Status(models.TextChoices):
        # Property_name = db_stored_value, "human_readable_label"
        PLANNING = "planning", "Planning"
        ACTIVE = "active", "Active"
        COMPLETED = "completed", "Completed"
        ARCHIVED = "archived", "Archived"
    
    title = models.CharField(max_length=200)
    story_setting = models.CharField(max_length=200, blank=True)
    description = models.TextField(blank=True)
    status = models.CharField(
        max_length=20, 
        choices=Status.choices, # uses the labels in the Status class
        default=Status.PLANNING,
    )
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ["-created_at"] # sets it in descending order
        
    def __str__(self):
        return self.title


# Individual Acts
class Act(models.Model):
    adventure = models.ForeignKey(
        "Adventure", # references the Adventure model
        on_delete=models.CASCADE, # required what happens on delete
        related_name="acts"
    )
    
    # Creating the columns for the column
    order = models.PositiveBigIntegerField(default=1)
    
    title = models.CharField(max_length=200, blank=True)
    summary = models.TextField(blank=True)
    plot_hooks = models.TextField(blank=True)
    story_beats = models.TextField(blank=True)
    climax = models.TextField(blank=True)
    gm_notes = models.TextField(blank=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    # Adding the Actors to the Act so that we can link them together
    actors = models.ManyToManyField(
        "Actor",
        related_name="acts",
        blank=True,
    )
    
    # Adding the environments to the Act so that we can link them together
    environments = models.ManyToManyField(
        "Environment",
        related_name="acts",
        blank=True,
    )
    
    # Adding the Actors to the Act so that we can link them together
    puzzles = models.ManyToManyField(
        "Puzzle",
        related_name="acts",
        blank=True,
    )
    
    class Meta:
        ordering = ["order"] # orders by column order ascending
        
    def __str__(self):
        return "Act %s: %s (%s)" % (self.order, self.title, self.adventure.title)
    

# Actors
class Actor(models.Model):
    class Kind(models.TextChoices):
        NPC = "npc", "NPC"
        ADVERSARY = "adversary", "Adversary"
        PC = "pc", "Player Character"
        
    name = models.CharField(max_length=200)
    kind = models.CharField(max_length=20, choices=Kind.choices, default=Kind.NPC)
    
    # narrative components
    motivation = models.TextField(blank=True)
    description = models.TextField(blank=True)
    notes = models.TextField(blank=True)
    
    # free form fields
    tier = models.CharField(max_length=50, blank=True)
    actor_type = models.CharField(max_length=100, blank=True)
    factions = models.JSONField(default=list, blank=True) # [guard,redbrand, etc]
    stats = models.JSONField(default=dict, blank=True) # {"Hit Points": 20, "Evasion": 12, "AC": 15}
    abilities = models.JSONField(default=dict, blank=True) # {"Str": 10, "Dex": 20}
    features = models.JSONField(default=list, blank=True) # [{"name": ..., "desc": ...}]
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


    class Meta:
        ordering = ["name"]
        
    def __str__(self):
        return "%s (%s)" % (self.name, self.get_kind_display())


# Environments
class Environment(models.Model):
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True) # Overall description of the environment
    sensory_details = models.TextField(blank=True) # Smell, Taste, etc
    hazards = models.TextField(blank=True) # This could be features or just regular hazards
    secrets = models.TextField(blank=True)
    notes = models.TextField(blank=True) # GM-only Notes
    tier = models.CharField(max_length=50, blank=True)
    environment_type = models.CharField(max_length=100, blank=True)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["name"]
        
    def __str__(self):
        return self.name
    
# Puzzles
class Puzzle(models.Model):
    class Status(models.TextChoices):
        DRAFT = "draft", "Draft"
        READY = "ready", "Ready"
        
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True) # What the players face
    notes = models.TextField(blank=True) # GM-only notes
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.DRAFT)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["name"]
        
    def __str__(self):
        return self.name
    
class PuzzleSolution(models.Model):
    class SolutionType(models.TextChoices):
        CORRECT = "correct", "Correct"
        ALTERNATE = "alternate", "Alternate"
        RED_HERRING = "red_herring", "Red herring"
        
    puzzle = models.ForeignKey(
        "Puzzle",
        on_delete=models.CASCADE,
        related_name="solutions"
    )
    tier = models.PositiveBigIntegerField(null=True, blank=True) # Solution ordering
    solution_type = models.CharField(max_length=20, choices=SolutionType.choices)
    description = models.TextField() # Required - a solution needs one
    notes = models.TextField(blank=True) # DM-only guidance
    
    class Meta:
        ordering = ["tier"]
        
    def __str__(self):
        return "%s — %s (tier %s)" % (self.puzzle.name, self.get_solution_type_display(), self.tier)
