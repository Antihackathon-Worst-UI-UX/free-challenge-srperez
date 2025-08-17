

if (browser_width != width || browser_height != height)
{
	width = browser_width;
	height = browser_height;
	
	var size = height;
	if (width < height) {
		size = width;
	}
	window_set_size(size, size);
	display_set_gui_size(size, size);
}