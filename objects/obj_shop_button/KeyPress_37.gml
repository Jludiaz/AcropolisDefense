// begin placement mode
var ctrl = global.gameController;
if (instance_exists(ctrl) && ctrl.money >= cost) {
    ctrl.building_mode = true;
    ctrl.build_tower_type = tower_type;
    ctrl.build_cost = cost;
}