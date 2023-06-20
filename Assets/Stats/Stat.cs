using Godot;

public partial class Stat : Node
{
    [Export]
    string statName;

    [Export]
    int maxValue = 10;

    public int CurrentValue { get; set; } = 10;

    public void Update(int newValue)
    {
        if (newValue <= maxValue)
            CurrentValue = newValue;
    }

    public void UpdateMax(int newMax) => maxValue = newMax;
}