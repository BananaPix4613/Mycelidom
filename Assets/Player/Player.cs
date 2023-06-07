using Godot;
using System;

public partial class Player: Node 
{
    [Export]
    float cameraLerpMagnitude = 1000f;

    [Export]
    float offsetNormalize = 350f;

    [Export]
    Camera2D Camera { get; set; }

    [Export]
    public AnimationNode AnimationsNode { get; set; }

    [Export]
    public StateManager States { get; set; }

    [Export]
    public StatsManager Stats { get; set; }

    [Signal]
    public delegate void UpdateStateEventHandler();

    [Signal]
    public delegate void UpdateHealthEventHandler();

    [Signal]
    public delegate void UpdateStaminaEventHandler();

    [Signal]
    public delegate void UpdateNutritionEventHandler();

    bool mouseIsClose = true;
    Vector2 mouseLerpSize = Vector2.Zero;

    public override void _Ready()
    {
        States.InitPlayer(this);
        // Stats.InitPlayer(this);
        mouseIsClose = false;
        mouseLerpSize = GetViewport().GetVisibleRect().Size;
    }

    public override void _UnhandledInput(InputEvent @event)
    {
        base._UnhandledInput(@event);
        States._Input(@event);
    }

    public override void _PhysicsProcess(double delta)
    {
        base._PhysicsProcess(delta);
        States._PhysicsProcess(delta);
        if (!mouseIsClose)
        {
            var mouseOffset = GetViewport().GetMousePosition() - (mouseLerpSize / 8);
            var x = Mathf.Lerp(0f, mouseOffset.Normalized().X * offsetNormalize, mouseOffset.X / cameraLerpMagnitude);
            var y = Mathf.Lerp(0f, mouseOffset.Normalized().Y * offsetNormalize, mouseOffset.Y / cameraLerpMagnitude);
            Camera.Position = new Vector2(x, y);
        }
    }

    public override void _Process(double delta)
    {
        base._Process(delta);
        States._Process(delta);
    }

    public void CurrentState(BaseState state)
    {
        EmitSignal(SignalName.UpdateState, state);
    }
}