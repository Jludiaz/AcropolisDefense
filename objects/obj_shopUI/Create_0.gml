/// obj_shopUI - Create Event
/// Manages tower shop interface

// Shop positioning
depth	= -1000
shop_x = room_width - 250;
shop_y = 50;
shop_width = 230;
shop_height = 600;

// Selected tower type (noone = no selection)
selected_tower = noone;

// Tower definitions [object, name, cost, description, icon_sprite]
tower_types = [
    {
        obj: obj_tower_basic,
        name: "Basic Tower",
        cost: 50,
        desc: "Balanced damage and speed",
        range: 160,
        damage: 8,
        fire_rate: "Medium"
    },
    {
        obj: obj_tower_sniper,
        name: "Sniper Tower",
        cost: 100,
        desc: "Long range, high damage",
        range: 300,
        damage: 20,
        fire_rate: "Slow"
    },
    {
        obj: obj_tower_rapid,
        name: "Rapid Tower",
        cost: 75,
        desc: "Fast firing, low damage",
        range: 120,
        damage: 3,
        fire_rate: "Very Fast"
    },
    {
        obj: obj_tower_splash,
        name: "Splash Tower",
        cost: 150,
        desc: "Area damage to enemies",
        range: 140,
        damage: 12,
        fire_rate: "Slow"
    }
];

// Button dimensions
button_height = 100;
button_padding = 10;

// Hover tracking
hovered_index = -1;