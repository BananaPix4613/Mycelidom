using System;
using Godot;

public partial class Move : BaseState
{
    [Export]
    float moveSpeed = 120.0f;

    [Export]
    Idle idle;

    [Export]
    Sprint sprint;

    [Export]
    Walk walk;

    [Export]
    Block block;

    [Export]
    Attack attack;

    [Export]
    Roll roll;

    string[] directions = 
    {   
        "walk_right",
        "walk_right_diagonal_down",
        "walk_down",
        "walk_left_diagonal_down",
        "walk_left",
        "walk_left_diagonal_up",
        "walk_up",
        "walk_right_diagonal_up"
    };

    string[] idleDirections = 
    {   
        "right",
        "right_diagonal_down",
        "down",
        "left_diagonal_down",
        "left",
        "left_diagonal_up",
        "up",
        "right_diagonal_up"
    };
    string[] rollDirections = 
    {   
        "roll_right",
        "roll_right_diagonal_down",
        "roll_down",
        "roll_left_diagonal_down",
        "roll_left",
        "roll_left_diagonal_up",
        "roll_up",
        "roll_right_diagonal_up"
    };

    Vector2 move;
    Vector2 facing;
    bool isRolling = false;

    public override void _Input(InputEvent @event)
    {
        if (Input.IsActionJustPressed("roll"))
        {
            if (roll.RollCooldown.TimeLeft == 0)
            {
                // State manager should be set to roll state
                NewState = roll;
            }
        }
    }

    public override void _PhysicsProcess(double delta)
    {
        base._PhysicsProcess(delta);

        var move = GetMovementInput();

        var animationIndex = GetDirectionIndex(facing);
        var animation = isRolling || (move.X == 0 && move.Y == 0)? idleDirections[animationIndex] : directions[animationIndex];
        if (Player.AnimationsNode.CurrentAnimation != animation)
            Player.AnimationsNode.Play(animation);

        move = move.Normalized();
        Player.Velocity = new Vector2(move.X * moveSpeed, move.Y * moveSpeed);
        Player.MoveAndSlide();
        
        if (move == Vector2.Zero && !isRolling) 
        {
            NewState = idle;
        }
    }

    public Vector2 GetMovementInput()
    {
        var left = Input.IsActionPressed("move_left");
        var right = Input.IsActionPressed("move_right");
        var up = Input.IsActionPressed("move_up");
        var down = Input.IsActionPressed("move_down");

        move.X = Convert.ToInt32(right) - Convert.ToInt32(left);
        move.Y = Convert.ToInt32(down) - Convert.ToInt32(up);

        if (left || right || up || down) facing = move;

        return move;
    }

    public int GetDirectionIndex(Vector2 direction)
    {
        double angle = direction.Angle();
        if (angle < 0) angle += 2 * Math.PI;
        double index = Math.Round(angle / Math.PI * 4);
        return (int)index;
    }
}