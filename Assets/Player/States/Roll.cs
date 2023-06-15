using Godot;

public partial class Roll : Move
{
    [Export]
    double rollTime = 0.4;
    
    [Export]
    double cooldown = 1;

    [Export]
    public Timer RollCooldown { get; set; }

    double currentRollTime = 0;
    Vector2 rollDirection;

    
}