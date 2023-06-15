using System;
using Godot;

public partial class UIManager : SubViewportContainer
{
    Player player;
    Area2D mouseDetector;
    Label stateLabel;
    Label healthLabel;
    Label staminaLabel;
    Label nutritionLabel;

    public override void _Ready()
    {
        base._Ready();

        player = GetNode<Player>("SubViewport/Scene/Player");
        mouseDetector = GetNode<Area2D>("MouseDetection");
        stateLabel = GetNode<Label>("DebugMenu/PanelContainer/MarginContainer/VBoxContainer/State");
        healthLabel = GetNode<Label>("DebugMenu/PanelContainer/MarginContainer/VBoxContainer/Health");
        staminaLabel = GetNode<Label>("DebugMenu/PanelContainer/MarginContainer/VBoxContainer/Stamina");
        nutritionLabel = GetNode<Label>("DebugMenu/PanelContainer/MarginContainer/VBoxContainer/Nutrition");

        mouseDetector?.Connect("mouse_entered", new Callable(player, "_mouse_entered"));
        mouseDetector?.Connect("mouse_exited", new Callable(player, "_mouse_exited"));

        player?.Connect("UpdateState", new Callable(this, "UpdateState"));
        player?.Connect("UpdateHealth", new Callable(this, "UpdateHealth"));
        player?.Connect("UpdateStamina", new Callable(this, "UpdateStamina"));
        player?.Connect("UpdateNutrition", new Callable(this, "UpdateNutrition"));
    }

    public void UpdateState(string state) => stateLabel.Text = state;

    public void UpdateHealth(string health) => healthLabel.Text = health;

    public void UpdateStamina(string stamina) => staminaLabel.Text = stamina;

    public void updateNutrition(string nutrition) => nutritionLabel.Text = nutrition;

    public void InitStats(double maxHealth, double maxStamina, double maxNutrition)
    {
        healthLabel.Text = $"Health: {maxHealth}/{maxHealth}";
        staminaLabel.Text = $"Stamina: {maxStamina}/{maxStamina}";
        nutritionLabel.Text = $"Nutrition: {maxNutrition}/{maxNutrition}";
    }
}