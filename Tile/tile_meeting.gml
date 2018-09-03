/// @argument x
/// @argument y
/// @argument tilemap_id

var _x    = argument0;
var _y    = argument1;
var _tile = argument2;
var _xDiff = _x - x;
var _yDiff = _y - y;
var _bboxL = bbox_left   + _xDiff;
var _bboxR = bbox_right  + _xDiff;
var _bboxT = bbox_top    + _yDiff;
var _bboxB = bbox_bottom + _yDiff;
var _left = 0;
var _right = 0;
var _top = 0;
var _bottom = 0;

// Left and Right
for (var _a = 0; _a < (bbox_bottom - bbox_top); ++_a) {
	_left = tilemap_get_at_pixel(_tile, _bboxL, _bboxT + _a);
	_right = tilemap_get_at_pixel(_tile, _bboxR, _bboxT + _a);
	if (_left || _right) {
		break;	
	}
}
// Top and Down
for (var _a = 0; _a < (bbox_right - bbox_left); ++_a) {
	_top = tilemap_get_at_pixel(_tile, _bboxL + _a, _bboxT);
	_bottom = tilemap_get_at_pixel(_tile, _bboxL + _a, _bboxB);
	if (_top || _bottom) {
		break;	
	}
}

return (_left || _right || _top || _bottom);