/// @description tile_collision(tilemap_id, speed, axis, tile_size_for_axis)
/// @argument tilemap_id
/// @argument speed
/// @argument axis
/// @argument tile_size_for_axis
var _lay = argument0;
var _spd = argument1;
var _axis = argument2;
var _size = argument3;
var _return = 0;
var _t, _side, _newpos;
if (string_lower(_axis) == "x" || string(_axis) == "0") {
	// Get Sprite BBox Relative to Origin
	var _spr_bbox_left   = sprite_get_bbox_left( sprite_index) - sprite_get_xoffset(sprite_index);
	var _spr_bbox_right  = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
	// Get BBox Height
	var _length = bbox_bottom - bbox_top;
	// Loop for Pixel Collisions
	for (var _a = 0; _a < _length; ++_a) {
		// Set Side and New Position
		if (_spd > 0) {
			_side	= bbox_right;
			_newpos = ((_side & ~(_size - 1)) - 1) - _spr_bbox_right;
		} else {
			_side = bbox_left;
			_newpos = ((_side + _size) & ~(_size - 1)) - _spr_bbox_left;
		}
		// Get Tile Index
		_t = tile_get_index(tilemap_get_at_pixel(_lay, _side, bbox_top + _a));
		// Set Position and Return Index
		if (_t) {
			x = _newpos;
			_return = _t;
		}
	}
} else if (string_lower(_axis) == "y" || string(_axis) == "1") {
	// Get Sprite BBox Relative to Origin
	var _spr_bbox_top	 = sprite_get_bbox_top(	  sprite_index) - sprite_get_yoffset(sprite_index);
	var _spr_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
	// Get BBox Width
	var _length = bbox_right - bbox_left;
	// Loop for Pixel Collisions
	for (var _a = 0; _a < _length; ++_a) {
		// Set Side and New Position
		if (_spd > 0) {
			_side = bbox_bottom;
			_newpos = ((_side & ~(_size - 1)) - 1) - _spr_bbox_bottom;
		} else {
			_side = bbox_top;
			_newpos = ((_side + _size) & ~(_size - 1)) - _spr_bbox_top;
		}
		// Get Tile Index
		_t = tilemap_get_at_pixel(_lay, bbox_left + _a, _side) & tile_index_mask;
		// Set Position and Return Index
		if (_t) {
			y = _newpos;
			_return = _t;	
		}
	}
}
// Return Index
return _return;